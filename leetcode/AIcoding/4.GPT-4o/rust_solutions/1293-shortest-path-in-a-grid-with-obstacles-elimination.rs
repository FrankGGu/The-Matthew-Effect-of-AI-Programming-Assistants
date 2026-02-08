use std::collections::{VecDeque, HashSet};

impl Solution {
    pub fn shortest_path(grid: Vec<Vec<i32>>, k: i32) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        if m == 0 || n == 0 { return -1; }
        let directions = vec![(1, 0), (0, 1), (-1, 0), (0, -1)];
        let mut queue = VecDeque::new();
        let mut visited = vec![vec![HashSet::new(); n]; m];
        queue.push_back((0, 0, k));
        visited[0][0].insert(k);
        let mut steps = 0;

        while !queue.is_empty() {
            for _ in 0..queue.len() {
                let (x, y, rem) = queue.pop_front().unwrap();
                if x == m - 1 && y == n - 1 { return steps; }
                for (dx, dy) in &directions {
                    let new_x = (x as isize + dx) as usize;
                    let new_y = (y as isize + dy) as usize;
                    if new_x < m && new_y < n {
                        let new_rem = rem - grid[new_x][new_y];
                        if new_rem >= 0 && !visited[new_x][new_y].contains(&new_rem) {
                            visited[new_x][new_y].insert(new_rem);
                            queue.push_back((new_x, new_y, new_rem));
                        }
                    }
                }
            }
            steps += 1;
        }
        -1
    }
}