impl Solution {

use std::collections::{HashSet, VecDeque};

impl Solution {
    pub fn maximum_minutes(grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        let cols = grid[0].len();
        let mut fires = Vec::new();

        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == 1 {
                    fires.push((i, j));
                }
            }
        }

        let mut dist = vec![vec![-1; cols]; rows];
        let mut queue = VecDeque::new();

        for (i, j) in &fires {
            dist[*i][*j] = 0;
            queue.push_back((*i, *j));
        }

        let directions = [(-1, 0), (1, 0), (0, -1), (0, 1)];

        while let Some((i, j)) = queue.pop_front() {
            for &(di, dj) in &directions {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;
                if ni >= 0 && ni < rows as i32 && nj >= 0 && nj < cols as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if dist[ni][nj] == -1 {
                        dist[ni][nj] = dist[i][j] + 1;
                        queue.push_back((ni, nj));
                    }
                }
            }
        }

        let mut visited = vec![vec![false; cols]; rows];
        let mut queue = VecDeque::new();

        for i in 0..rows {
            for j in 0..cols {
                if grid[i][j] == 0 {
                    if i == 0 || i == rows - 1 || j == 0 || j == cols - 1 {
                        queue.push_back((i, j));
                        visited[i][j] = true;
                    }
                }
            }
        }

        while let Some((i, j)) = queue.pop_front() {
            if i == rows - 1 || j == cols - 1 {
                return 24 * 60;
            }

            for &(di, dj) in &directions {
                let ni = i as i32 + di;
                let nj = j as i32 + dj;
                if ni >= 0 && ni < rows as i32 && nj >= 0 && nj < cols as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if !visited[ni][nj] && grid[ni][nj] == 0 {
                        if dist[ni][nj] > dist[i][j] + 1 || (dist[ni][nj] == dist[i][j] + 1 && dist[ni][nj] != -1) {
                            visited[ni][nj] = true;
                            queue.push_back((ni, nj));
                        }
                    }
                }
            }
        }

        -1
    }
}
}