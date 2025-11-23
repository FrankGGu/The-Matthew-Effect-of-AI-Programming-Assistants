impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn remove_adjacent(s: String) -> String {
        let mut stack = VecDeque::new();
        for c in s.chars() {
            if let Some(&last) = stack.back() {
                if last == c {
                    stack.pop_back();
                } else {
                    stack.push_back(c);
                }
            } else {
                stack.push_back(c);
            }
        }
        stack.into_iter().collect()
    }
}
}