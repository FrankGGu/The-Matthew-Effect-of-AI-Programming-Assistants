impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn shortest_bridge(mut grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut visited = HashSet::new();
        let mut queue = VecDeque::new();

        for i in 0..n {
            for j in 0..n {
                if grid[i][j] == 1 {
                    Self::dfs(&mut grid, i, j, &mut visited, &mut queue);
                    break;
                }
            }
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        while !queue.is_empty() {
            let (x, y, dist) = queue.pop_front().unwrap();
            for &(dx, dy) in &directions {
                let nx = x as i32 + dx;
                let ny = y as i32 + dy;
                if nx >= 0 && ny >= 0 && nx < n as i32 && ny < n as i32 {
                    let nx = nx as usize;
                    let ny = ny as usize;
                    if !visited.contains(&(nx, ny)) {
                        if grid[nx][ny] == 1 {
                            return dist;
                        }
                        visited.insert((nx, ny));
                        queue.push_back((nx, ny, dist + 1));
                    }
                }
            }
        }

        -1
    }

    fn dfs(
        grid: &mut Vec<Vec<i32>>,
        i: usize,
        j: usize,
        visited: &mut HashSet<(usize, usize)>,
        queue: &mut VecDeque<(usize, usize, i32)>,
    ) {
        if i >= grid.len() || j >= grid[0].len() || grid[i][j] == 0 || visited.contains(&(i, j)) {
            return;
        }

        visited.insert((i, j));
        queue.push_back((i, j, 0));

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];
        for &(dx, dy) in &directions {
            let ni = i as i32 + dx;
            let nj = j as i32 + dy;
            if ni >= 0 && nj >= 0 && ni < grid.len() as i32 && nj < grid[0].len() as i32 {
                Self::dfs(grid, ni as usize, nj as usize, visited, queue);
            }
        }
    }
}
}