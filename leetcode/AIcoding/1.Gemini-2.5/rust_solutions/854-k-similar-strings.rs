use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn k_similar(s1: String, s2: String) -> i32 {
        let n = s1.len();
        let s2_chars: Vec<char> = s2.chars().collect();

        let mut queue: VecDeque<(Vec<char>, i32)> = VecDeque::new();
        let mut visited: HashSet<Vec<char>> = HashSet::new();

        let s1_initial_chars: Vec<char> = s1.chars().collect();
        queue.push_back((s1_initial_chars.clone(), 0));
        visited.insert(s1_initial_chars);

        while let Some((mut current_s_chars, swaps)) = queue.pop_front() {
            if current_s_chars == s2_chars {
                return swaps;
            }

            let mut i = 0;
            while i < n && current_s_chars[i] == s2_chars[i] {
                i += 1;
            }

            for j in i + 1..n {
                if current_s_chars[j] == s2_chars[i] {
                    // Optimization:
                    // Only consider swapping if current_s_chars[j] is not already in its correct place (s2_chars[j]).
                    // If current_s_chars[j] == s2_chars[j], swapping it with current_s_chars[i] (which is misplaced)
                    // would make position j incorrect. This is generally not optimal.
                    // The only exception would be if current_s_chars[i] == s2_chars[j] (a perfect 2-cycle swap),
                    // but this is impossible under the conditions:
                    // 1. current_s_chars[i] != s2_chars[i] (definition of i)
                    // 2. current_s_chars[j] == s2_chars[i] (candidate for swap)
                    // 3. current_s_chars[j] == s2_chars[j] (pruning condition negated)
                    // If 1, 2, 3 were true, it would imply s2_chars[i] == s2_chars[j] and current_s_chars[i] != s2_chars[i].
                    // If current_s_chars[i] == s2_chars[j] was also true, then current_s_chars[i] == s2_chars[i], a contradiction.
                    // Thus, the condition `current_s_chars[j] != s2_chars[j]` is robust.
                    if current_s_chars[j] != s2_chars[j] {
                        let mut next_s_chars = current_s_chars.clone();
                        next_s_chars.swap(i, j);

                        if visited.insert(next_s_chars.clone()) {
                            queue.push_back((next_s_chars, swaps + 1));
                        }
                    }
                }
            }
        }

        unreachable!()
    }
}