use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn is_escapable(grid: Vec<Vec<i32>>) -> bool {
        let n = grid.len();
        let m = grid[0].len();
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();
        queue.push_back((0, 0));
        visited.insert((0, 0));

        while let Some((x, y)) = queue.pop_front() {
            if x == n - 1 && y == m - 1 {
                return true;
            }
            let val = grid[x][y];
            let mut i = 1;
            while i * i <= val {
                if val % i == 0 {
                    let a = i as usize;
                    let b = (val / i) as usize;
                    for &(dx, dy) in &[(a, b), (b, a)] {
                        let nx = x + dx;
                        let ny = y + dy;
                        if nx < n && ny < m && !visited.contains(&(nx, ny)) {
                            visited.insert((nx, ny));
                            queue.push_back((nx, ny));
                        }
                        if nx == n - 1 && ny == m - 1 {
                            return true;
                        }
                    }
                }
                i += 1;
            }
        }
        false
    }
}