impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn crack_safe(n: i32, k: i32) -> String {
        if n == 1 {
            return (0..k).map(|i| (b'0' + i as u8) as char).collect();
        }

        let mut visited = HashSet::new();
        let mut result = String::new();
        let mut queue = VecDeque::new();

        for i in 0..k {
            let s = format!("{}", i);
            queue.push_back(s);
            visited.insert(s);
        }

        while let Some(mut s) = queue.pop_front() {
            if s.len() == (n as usize) {
                result = s;
                break;
            }

            for i in 0..k {
                let next = format!("{}{}", &s[1..], i);
                if !visited.contains(&next) {
                    visited.insert(next.clone());
                    queue.push_back(next);
                    s = format!("{}{}", s, i);
                }
            }
        }

        result
    }
}
}