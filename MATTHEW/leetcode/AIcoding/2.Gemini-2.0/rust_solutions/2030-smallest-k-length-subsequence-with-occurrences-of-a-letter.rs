impl Solution {
    pub fn smallest_subsequence(s: String, k: i32, letter: char, repetition: i32) -> String {
        let n = s.len();
        let k = k as usize;
        let repetition = repetition as usize;
        let mut letter_count = 0;
        for &c in s.as_bytes() {
            if c as char == letter {
                letter_count += 1;
            }
        }

        let mut stack: Vec<char> = Vec::new();
        let mut need = repetition;

        for i in 0..n {
            let c = s.as_bytes()[i] as char;
            while !stack.is_empty()
                && c < *stack.last().unwrap()
                && n - i + stack.len() > k
                && (stack.last().unwrap() != &letter || need < letter_count)
            {
                let popped = stack.pop().unwrap();
                if popped == letter {
                    need -= 1;
                }
            }

            if stack.len() < k {
                if c == letter {
                    stack.push(c);
                    need += 1;
                    letter_count -= 1;
                } else if k - stack.len() > repetition - need {
                    stack.push(c);
                } else {
                    letter_count -=1;
                }
            } else {
                letter_count -= 1;
            }
        }

        stack.into_iter().collect()
    }
}