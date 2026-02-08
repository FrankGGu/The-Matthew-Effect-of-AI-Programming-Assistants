use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn racecar(target: i32) -> i32 {
        let mut queue = VecDeque::new();
        queue.push_back((0, 1, 0));
        let mut visited = HashSet::new();
        visited.insert((0, 1));

        while let Some((pos, speed, steps)) = queue.pop_front() {
            if pos == target {
                return steps;
            }
            // Accelerate
            let new_pos = pos + speed;
            let new_speed = speed * 2;
            if !visited.contains(&(new_pos, new_speed)) && new_pos.abs() < 2 * target {
                visited.insert((new_pos, new_speed));
                queue.push_back((new_pos, new_speed, steps + 1));
            }
            // Reverse
            let new_speed = if speed > 0 { -1 } else { 1 };
            if !visited.contains(&(pos, new_speed)) {
                visited.insert((pos, new_speed));
                queue.push_back((pos, new_speed, steps + 1));
            }
        }
        -1
    }
}