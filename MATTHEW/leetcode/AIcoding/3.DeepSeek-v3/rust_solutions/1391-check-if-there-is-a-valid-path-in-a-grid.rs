impl Solution {
    pub fn has_valid_path(grid: Vec<Vec<i32>>) -> bool {
        let m = grid.len();
        let n = grid[0].len();
        let mut visited = vec![vec![false; n]; m];
        let mut queue = std::collections::VecDeque::new();
        queue.push_back((0, 0));
        visited[0][0] = true;

        let dirs = vec![(-1, 0), (1, 0), (0, -1), (0, 1)];
        let street_connects = vec![
            vec![], 
            vec![2, 3], 
            vec![0, 1], 
            vec![2, 1], 
            vec![3, 1], 
            vec![0, 2], 
            vec![0, 3]
        ];

        while let Some((i, j)) = queue.pop_front() {
            if i == m - 1 && j == n - 1 {
                return true;
            }
            let street = grid[i][j] as usize;
            for &d in &street_connects[street] {
                let (di, dj) = dirs[d];
                let ni = i as i32 + di;
                let nj = j as i32 + dj;
                if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 {
                    let ni = ni as usize;
                    let nj = nj as usize;
                    if !visited[ni][nj] {
                        let next_street = grid[ni][nj] as usize;
                        let opposite_d = match d {
                            0 => 1,
                            1 => 0,
                            2 => 3,
                            3 => 2,
                            _ => unreachable!(),
                        };
                        if street_connects[next_street].contains(&opposite_d) {
                            visited[ni][nj] = true;
                            queue.push_back((ni, nj));
                        }
                    }
                }
            }
        }
        false
    }
}