use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn remove_duplicate_letters(s: String) -> String {
        let mut counts: [i32; 26] = [0; 26];
        for c in s.chars() {
            counts[c as usize - 'a' as usize] += 1;
        }

        let mut stack: Vec<char> = Vec::new();
        let mut in_stack: [bool; 26] = [false; 26];

        for c in s.chars() {
            let c_idx = c as usize - 'a' as usize;
            counts[c_idx] -= 1;

            if in_stack[c_idx] {
                continue;
            }

            while let Some(&top_char) = stack.last() {
                let top_idx = top_char as usize - 'a' as usize;
                if c < top_char && counts[top_idx] > 0 {
                    stack.pop();
                    in_stack[top_idx] = false;
                } else {
                    break;
                }
            }

            stack.push(c);
            in_stack[c_idx] = true;
        }

        stack.iter().collect()
    }
}