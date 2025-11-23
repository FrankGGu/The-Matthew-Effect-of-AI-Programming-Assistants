impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn can_measure_water(x: i32, y: i32, z: i32) -> bool {
        if z == 0 {
            return true;
        }
        if x + y < z {
            return false;
        }
        let mut visited = HashSet::new();
        let mut queue = vec![0];
        while let Some(current) = queue.pop() {
            if current == z {
                return true;
            }
            if visited.contains(&current) {
                continue;
            }
            visited.insert(current);
            let nexts = vec![
                current + x,
                current - x,
                current + y,
                current - y,
            ];
            for next in nexts {
                if next >= 0 && next <= x + y && !visited.contains(&next) {
                    queue.push(next);
                }
            }
        }
        false
    }
}
}