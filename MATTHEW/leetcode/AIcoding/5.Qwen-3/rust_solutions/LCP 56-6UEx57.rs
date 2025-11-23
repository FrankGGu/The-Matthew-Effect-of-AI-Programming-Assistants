impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn open_lock(mut deadends: Vec<String>, mut target: String) -> i32 {
        let mut dead = HashSet::new();
        for d in deadends {
            dead.insert(d);
        }

        let target_str = target.clone();
        let mut queue = VecDeque::new();
        queue.push_back("0000".to_string());
        let mut visited = HashSet::new();
        visited.insert("0000".to_string());

        let mut steps = 0;

        while !queue.is_empty() {
            let size = queue.len();
            for _ in 0..size {
                let current = queue.pop_front().unwrap();

                if current == target_str {
                    return steps;
                }

                if dead.contains(&current) {
                    continue;
                }

                for i in 0..4 {
                    for delta in [-1, 1] {
                        let mut next = current.clone();
                        let digit = next.as_bytes()[i] as i32 - b'0' as i32;
                        let new_digit = (digit + delta + 10) % 10;
                        next.as_bytes_mut()[i] = (new_digit + b'0') as u8;

                        if !visited.contains(&next) && !dead.contains(&next) {
                            visited.insert(next.clone());
                            queue.push_back(next);
                        }
                    }
                }
            }
            steps += 1;
        }

        -1
    }
}
}