impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn electric_car_travel(n: i32, t: i32, m: i32, s: Vec<i32>) -> i32 {
        let mut queue = VecDeque::new();
        for &val in &s {
            queue.push_back(val);
        }

        let mut time = 0;
        let mut current = 0;

        while !queue.is_empty() {
            let mut count = 0;
            while count < m && !queue.is_empty() {
                let station = queue.front().unwrap();
                if *station <= time {
                    queue.pop_front();
                    count += 1;
                } else {
                    break;
                }
            }

            if count == 0 {
                time = queue.front().unwrap();
                continue;
            }

            time += t;
            current += 1;
        }

        current
    }
}
}