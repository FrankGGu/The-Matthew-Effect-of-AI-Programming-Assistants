impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn race_car(mut target: i32) -> i32 {
        let mut queue = VecDeque::new();
        queue.push_back((0, 0, 1)); // (position, steps, speed)
        let mut visited = std::collections::HashSet::new();
        visited.insert((0, 1));

        while let Some((pos, steps, speed)) = queue.pop_front() {
            if pos == target {
                return steps;
            }

            let next_pos = pos + speed;
            let next_steps = steps + 1;
            let next_speed = speed * 2;

            if next_pos == target {
                return next_steps;
            }

            if next_pos > 0 && next_pos < target * 2 && !visited.contains(&(next_pos, next_speed)) {
                visited.insert((next_pos, next_speed));
                queue.push_back((next_pos, next_steps, next_speed));
            }

            let reverse_speed = if speed > 0 { -1 } else { 1 };
            let reverse_pos = pos;
            let reverse_steps = steps + 1;
            let reverse_speed = reverse_speed;

            if !visited.contains(&(reverse_pos, reverse_speed)) {
                visited.insert((reverse_pos, reverse_speed));
                queue.push_back((reverse_pos, reverse_steps, reverse_speed));
            }
        }

        -1
    }
}

struct Solution {}
}