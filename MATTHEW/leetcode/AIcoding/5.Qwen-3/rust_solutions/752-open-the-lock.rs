impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn open_lock(mut deadends: Vec<String>, target: String) -> i32 {
        let mut dead_set = HashSet::new();
        for d in deadends {
            dead_set.insert(d);
        }

        let start = "0000".to_string();
        if start == target {
            return 0;
        }

        if dead_set.contains(&start) {
            return -1;
        }

        let mut queue = VecDeque::new();
        queue.push_back((start, 0));
        let mut visited = HashSet::new();
        visited.insert(start);

        while let Some((current, steps)) = queue.pop_front() {
            for i in 0..4 {
                for delta in [-1, 1] {
                    let mut next = current.clone();
                    let digit = (next.chars().nth(i).unwrap() as u8 - b'0') as i32;
                    let new_digit = (digit + delta + 10) % 10;
                    next.replace_range(i..i+1, &new_digit.to_string());

                    if next == target {
                        return steps + 1;
                    }

                    if !visited.contains(&next) && !dead_set.contains(&next) {
                        visited.insert(next.clone());
                        queue.push_back((next, steps + 1));
                    }
                }
            }
        }

        -1
    }
}
}