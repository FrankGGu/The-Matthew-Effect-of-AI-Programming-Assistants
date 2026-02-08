impl Solution {
    pub fn smallest_subsequence(s: String, k: i32, letter: char, occurrence: i32) -> String {
        let n = s.len();
        let k = k as usize;
        let occurrence = occurrence as usize;
        let s_chars: Vec<char> = s.chars().collect();

        // suffix_letter_counts[i] stores the count of 'letter' in s[i..n]
        let mut suffix_letter_counts: Vec<usize> = vec![0; n + 1];
        for i in (0..n).rev() {
            suffix_letter_counts[i] = suffix_letter_counts[i + 1];
            if s_chars[i] == letter {
                suffix_letter_counts[i] += 1;
            }
        }

        let mut stack: Vec<char> = Vec::with_capacity(k);
        let mut stack_letter_count: usize = 0;

        for i in 0..n {
            let c = s_chars[i];

            // Popping loop: Remove larger characters from the stack if `c` is smaller,
            // and conditions for length and letter occurrence are met.
            while let Some(&top) = stack.last() {
                // Condition 1: `c` is lexicographically smaller than `top`.
                if c >= top {
                    break;
                }

                // Condition 2: Popping `top` would make it impossible to reach length `k`.
                // `stack.len() - 1` (after pop) + `(n - i)` (chars from `s[i..]`, including `c`) < `k`.
                if stack.len() - 1 + (n - i) < k {
                    break;
                }

                // Condition 3: Popping `top` (if it's `letter`) would make it impossible to reach `occurrence`.
                if top == letter {
                    // `suffix_letter_counts[i]` is count of `letter` in `s[i..n]`.
                    if stack_letter_count - 1 + suffix_letter_counts[i] < occurrence {
                        break; // Cannot pop this `letter`, it's needed.
                    }
                    stack_letter_count -= 1;
                }
                stack.pop();
            }

            // Pushing `c` logic
            // We always try to push `c` if `stack.len() < k`.
            // If `stack.len() == k`, we can only push `c` under specific conditions related to `letter` and `occurrence`.
            let mut pushed = false;
            if stack.len() < k {
                stack.push(c);
                if c == letter {
                    stack_letter_count += 1;
                }
                pushed = true;
            } else { // stack.len() == k
                if c == letter {
                    if stack_letter_count < occurrence {
                        // We need this 'letter'. We must replace `stack.last()` if it's a non-'letter'.
                        if *stack.last().unwrap() != letter {
                            // Replace non-'letter' at top with 'c' (which is 'letter').
                            stack.pop();
                            stack.push(c);
                            stack_letter_count += 1;
                            pushed = true;
                        }
                        // Else: stack.last() is also 'letter'. We don't push 'c' because:
                        // 1. `c` is not smaller than `stack.last()` (otherwise it would have been popped by the `while` loop).
                        // 2. We can't pop `stack.last()` because it's a 'letter' we might need (and `c` is not smaller).
                    }
                    // Else if `stack_letter_count == occurrence`: stack is full, already have enough letters. Don't push `c`.
                }
                // Else (`c` is not 'letter'): stack is full, `c` is non-letter. Don't push `c`.
            }
        }

        stack.into_iter().collect()
    }
}