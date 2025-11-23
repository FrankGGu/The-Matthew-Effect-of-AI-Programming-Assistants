impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn count_students(mut students: Vec<i32>, mut sandwiches: Vec<i32>) -> i32 {
        let mut queue = VecDeque::new();
        for s in students {
            queue.push_back(s);
        }

        let mut sandwich_idx = 0;

        while !queue.is_empty() {
            let front = *queue.front().unwrap();
            if front == sandwiches[sandwich_idx] {
                queue.pop_front();
                sandwich_idx += 1;
            } else {
                let mut found = false;
                for i in 0..queue.len() {
                    if queue[i] == sandwiches[sandwich_idx] {
                        found = true;
                        break;
                    }
                }
                if !found {
                    break;
                }
                let front = queue.pop_front().unwrap();
                queue.push_back(front);
            }
        }

        queue.len() as i32
    }
}
}