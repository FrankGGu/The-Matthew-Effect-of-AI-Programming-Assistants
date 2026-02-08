use std::collections::VecDeque;

impl Solution {
    pub fn racecar(target: i32) -> i32 {
        let mut queue = VecDeque::new();
        queue.push_back((0, 1, 0));

        let mut visited = std::collections::HashSet::new();
        visited.insert((0, 1));

        while let Some((pos, speed, steps)) = queue.pop_front() {
            if pos == target {
                return steps;
            }

            let next_pos = pos + speed;
            let next_speed = speed * 2;

            if next_pos.abs() <= target * 2 && !visited.contains(&(next_pos, next_speed)) {
                queue.push_back((next_pos, next_speed, steps + 1));
                visited.insert((next_pos, next_speed));
            }

            let reverse_speed = if speed > 0 { -1 } else { 1 };
            if !visited.contains(&(pos, reverse_speed)) {
                queue.push_back((pos, reverse_speed, steps + 1));
                visited.insert((pos, reverse_speed));
            }
        }

        0
    }
}

struct Solution;