impl Solution {
    pub fn smallest_subsequence(s: String, k: i32, letter: char, repetition: i32) -> String {
        let s = s.chars().collect::<Vec<_>>();
        let k = k as usize;
        let repetition = repetition as usize;
        let n = s.len();
        let mut letter_count = s.iter().filter(|&c| *c == letter).count();
        let mut stack = Vec::new();

        for (i, &c) in s.iter().enumerate() {
            while let Some(&top) = stack.last() {
                if c < top 
                    && stack.len() + n - i > k 
                    && (top != letter || letter_count > repetition) 
                {
                    if top == letter {
                        letter_count -= 1;
                    }
                    stack.pop();
                } else {
                    break;
                }
            }
            if stack.len() < k {
                if c == letter {
                    stack.push(c);
                } else if k - stack.len() > repetition.saturating_sub(letter_count) {
                    stack.push(c);
                }
            }
            if c == letter {
                letter_count -= 1;
            }
        }

        stack.into_iter().collect()
    }
}