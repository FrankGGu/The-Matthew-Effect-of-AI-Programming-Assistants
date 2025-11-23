use std::collections::HashSet;
use std::collections::VecDeque;

impl Solution {
    pub fn is_escape_possible(blocked: Vec<Vec<i32>>, source: Vec<i32>, target: Vec<i32>) -> bool {
        if blocked.len() > 20000 {
            return true;
        }

        let blocked_set: HashSet<(i32, i32)> = blocked.into_iter().map(|v| (v[0], v[1])).collect();

        let max_reachable = blocked_set.len() as i32 * (blocked_set.len() as i32 - 1) / 2;

        Self::can_reach(&source, &target, &blocked_set, max_reachable) &&
        Self::can_reach(&target, &source, &blocked_set, max_reachable)
    }

    fn can_reach(start: &Vec<i32>, target: &Vec<i32>, blocked: &HashSet<(i32, i32)>, max_reachable: i32) -> bool {
        let mut visited: HashSet<(i32, i32)> = HashSet::new();
        let mut queue: VecDeque<(i32, i32)> = VecDeque::new();
        queue.push_back((start[0], start[1]));
        visited.insert((start[0], start[1]));

        let directions: [(i32, i32); 4] = [(0, 1), (0, -1), (1, 0), (-1, 0)];

        while let Some((x, y)) = queue.pop_front() {
            if x == target[0] && y == target[1] {
                return true;
            }

            for &(dx, dy) in &directions {
                let nx = x + dx;
                let ny = y + dy;

                if nx >= 0 && nx < 1000000 && ny >= 0 && ny < 1000000 &&
                   !blocked.contains(&(nx, ny)) && !visited.contains(&(nx, ny)) {
                    visited.insert((nx, ny));
                    queue.push_back((nx, ny));

                    if visited.len() as i32 > max_reachable {
                        return true;
                    }
                }
            }
        }

        false
    }
}