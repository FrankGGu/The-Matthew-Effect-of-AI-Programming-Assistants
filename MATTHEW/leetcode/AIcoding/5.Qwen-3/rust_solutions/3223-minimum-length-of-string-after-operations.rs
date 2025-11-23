impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn minimum_length(s: String) -> i32 {
        let mut dq = VecDeque::new();
        for c in s.chars() {
            dq.push_back(c);
        }

        while dq.len() > 1 {
            let first = dq.front().unwrap();
            let last = dq.back().unwrap();

            if first != last {
                break;
            }

            if dq.len() == 2 {
                return 0;
            }

            dq.pop_front();
            dq.pop_back();
        }

        dq.len() as i32
    }
}
}