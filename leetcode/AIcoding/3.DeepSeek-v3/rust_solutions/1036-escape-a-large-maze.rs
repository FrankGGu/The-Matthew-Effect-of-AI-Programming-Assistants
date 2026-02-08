use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn is_escape_possible(blocked: Vec<Vec<i32>>, source: Vec<i32>, target: Vec<i32>>) -> bool {
        let blocked_set: HashSet<(i32, i32)> = blocked.into_iter().map(|v| (v[0], v[1])).collect();
        let source = (source[0], source[1]);
        let target = (target[0], target[1]);

        Self::bfs(source, target, &blocked_set) && Self::bfs(target, source, &blocked_set)
    }

    fn bfs(start: (i32, i32), end: (i32, i32), blocked: &HashSet<(i32, i32)>) -> bool {
        let dirs = [(0, 1), (1, 0), (0, -1), (-1, 0)];
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back(start);
        visited.insert(start);
        let max_area = (blocked.len() * blocked.len()) as i32 / 2;

        while let Some((x, y)) = queue.pop_front() {
            if (x, y) == end || visited.len() as i32 > max_area {
                return true;
            }
            for &(dx, dy) in &dirs {
                let nx = x + dx;
                let ny = y + dy;
                if nx >= 0 && nx < 1_000_000 && ny >= 0 && ny < 1_000_000 && !blocked.contains(&(nx, ny)) && !visited.contains(&(nx, ny)) {
                    visited.insert((nx, ny));
                    queue.push_back((nx, ny));
                }
            }
        }
        false
    }
}