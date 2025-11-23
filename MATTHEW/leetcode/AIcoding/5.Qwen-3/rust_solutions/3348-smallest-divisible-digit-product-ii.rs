impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn min_special_multiple(n: i32) -> i32 {
        let mut queue = vec![1];
        let mut visited = HashSet::new();
        visited.insert(1);

        while let Some(num) = queue.pop() {
            if num % n == 0 {
                return num;
            }
            for d in 1..=9 {
                let next = num * 10 + d;
                if !visited.contains(&next) {
                    visited.insert(next);
                    queue.push(next);
                }
            }
        }

        -1
    }
}
}