impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn can_win(n: i32) -> bool {
        let mut seen = HashSet::new();
        let mut queue = vec![n];
        seen.insert(n);

        while let Some(current) = queue.pop() {
            if current == 0 {
                return false;
            }
            for i in 1..=current {
                let next = current - i;
                if !seen.contains(&next) {
                    seen.insert(next);
                    queue.push(next);
                }
            }
        }
        true
    }
}
}