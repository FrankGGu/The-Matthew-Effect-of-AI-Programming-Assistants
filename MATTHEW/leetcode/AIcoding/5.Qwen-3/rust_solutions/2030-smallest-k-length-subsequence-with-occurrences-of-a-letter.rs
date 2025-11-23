impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn smallest_k_subsequence(s: String, k: i32, letter: char, count: i32) -> String {
        let k = k as usize;
        let count = count as usize;
        let mut stack = Vec::new();
        let mut total_letter = 0;
        for c in s.chars() {
            if c == letter {
                total_letter += 1;
            }
        }

        let mut remaining = s.len();
        let mut used = 0;
        let mut need = count;
        let mut remove = 0;

        for (i, c) in s.chars().enumerate() {
            while !stack.is_empty() && stack.last().unwrap() > &c && (used < k - 1 || (stack.last().unwrap() == &letter && need > 0)) {
                let top = stack.pop().unwrap();
                if top == letter {
                    need += 1;
                }
                used -= 1;
            }

            if c == letter {
                used += 1;
                need -= 1;
            }

            stack.push(c);
            remaining -= 1;
        }

        let mut result = Vec::with_capacity(k);
        let mut need = count;
        for c in stack {
            if c == letter {
                if need > 0 {
                    result.push(c);
                    need -= 1;
                }
            } else {
                result.push(c);
            }
        }

        result.into_iter().take(k).collect()
    }
}
}