use std::collections::HashSet;
use std::collections::VecDeque;

impl Solution {
    pub fn is_reachable(target_x: i32, target_y: i32) -> bool {
        let mut queue = VecDeque::new();
        let mut visited = HashSet::new();
        queue.push_back((target_x, target_y));
        visited.insert((target_x, target_y));

        while let Some((x, y)) = queue.pop_front() {
            if x == 1 && y == 1 {
                return true;
            }
            if x % 2 == 0 {
                let new_x = x / 2;
                if !visited.contains(&(new_x, y)) {
                    visited.insert((new_x, y));
                    queue.push_back((new_x, y));
                }
            }
            if y % 2 == 0 {
                let new_y = y / 2;
                if !visited.contains(&(x, new_y))) {
                    visited.insert((x, new_y));
                    queue.push_back((x, new_y));
                }
            }
            if x + y > 0 {
                let new_xy = (x, y - x);
                if x < y && !visited.contains(&new_xy) {
                    visited.insert(new_xy);
                    queue.push_back(new_xy);
                }
                let new_yx = (x - y, y);
                if y < x && !visited.contains(&new_yx) {
                    visited.insert(new_yx);
                    queue.push_back(new_yx);
                }
            }
        }
        false
    }
}