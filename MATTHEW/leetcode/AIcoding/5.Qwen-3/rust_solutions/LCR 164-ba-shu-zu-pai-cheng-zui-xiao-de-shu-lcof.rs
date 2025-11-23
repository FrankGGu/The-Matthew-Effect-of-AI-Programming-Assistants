impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn crack_opening_password(n: i32, k: i32) -> String {
        let mut visited = std::collections::HashSet::new();
        let mut result = Vec::with_capacity((10_i32.pow(n as u32)) as usize);
        let mut queue = VecDeque::new();

        for i in 0..10 {
            let s = format!("{}", i);
            if s.len() == n as usize {
                queue.push_back(s);
                visited.insert(s);
            }
        }

        while let Some(current) = queue.pop_front() {
            result.push(current.clone());
            for i in 0..10 {
                let next = format!("{}{}", &current[1..], i);
                if !visited.contains(&next) {
                    visited.insert(next.clone());
                    queue.push_back(next);
                }
            }
        }

        result.join("")
    }
}

struct Solution {}
}