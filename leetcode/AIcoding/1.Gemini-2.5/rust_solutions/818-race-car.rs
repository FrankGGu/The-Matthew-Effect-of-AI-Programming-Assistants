use std::collections::{VecDeque, HashSet};

struct Solution;

impl Solution {
    pub fn racecar(target: i32) -> i32 {
        let mut queue: VecDeque<(i32, i32, i32)> = VecDeque::new();
        let mut visited: HashSet<(i32, i32)> = HashSet::new();

        queue.push_back((0, 1, 0));
        visited.insert((0, 1));

        let max_pos_bound = target * 2 + 100;
        let min_pos_bound = -100; 
        let max_speed_abs_bound = target * 2 + 100;

        while let Some((pos, speed, steps)) = queue.pop_front() {
            if pos == target {
                return steps;
            }

            // Option 1: Accelerate ('A')
            let next_pos_a = pos + speed;
            let next_speed_a = speed * 2;

            if next_pos_a >= min_pos_bound && next_pos_a <= max_pos_bound &&
               next_speed_a.abs() <= max_speed_abs_bound &&
               visited.insert((next_pos_a, next_speed_a)) {
                queue.push_back((next_pos_a, next_speed_a, steps + 1));
            }

            // Option 2: Reverse ('R')
            let next_pos_r = pos;
            let next_speed_r = if speed > 0 { -1 } else { 1 };

            if visited.insert((next_pos_r, next_speed_r)) {
                queue.push_back((next_pos_r, next_speed_r, steps + 1));
            }
        }

        unreachable!();
    }
}