impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn people_aware_of_secret(n: i32, k: i32) -> i32 {
        let mut queue = VecDeque::new();
        queue.push_back(1);
        let mut time = 1;
        let mut count = 1;

        while time < n {
            let size = queue.len();
            for _ in 0..size {
                let person = queue.pop_front().unwrap();
                if person + k <= n {
                    queue.push_back(person + k);
                    count += 1;
                }
            }
            time += 1;
        }

        count
    }
}

struct Solution;
}