impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn find_the_winner(n: i32, k: i32) -> i32 {
        let mut queue = VecDeque::new();
        for i in 1..=n {
            queue.push_back(i);
        }

        while queue.len() > 1 {
            for _ in 0..k - 1 {
                if let Some(val) = queue.pop_front() {
                    queue.push_back(val);
                }
            }
            queue.pop_front();
        }

        queue.pop_front().unwrap()
    }
}
}