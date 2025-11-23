impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn split_into_groups(s: String, k: i32) -> Vec<String> {
        let k = k as usize;
        let mut result = Vec::new();
        let mut queue = VecDeque::new();

        for c in s.chars() {
            queue.push_back(c);
            if queue.len() == k {
                let group: String = queue.into_iter().collect();
                result.push(group);
                queue.clear();
            }
        }

        result
    }
}
}