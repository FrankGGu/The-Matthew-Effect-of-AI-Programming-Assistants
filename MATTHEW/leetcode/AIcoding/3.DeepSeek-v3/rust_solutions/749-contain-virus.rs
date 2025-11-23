impl Solution {
    pub fn contain_virus(mut is_infected: Vec<Vec<i32>>) -> i32 {
        let m = is_infected.len();
        if m == 0 { return 0; }
        let n = is_infected[0].len();
        let mut walls = 0;

        loop {
            let mut regions = Vec::new();
            let mut dangers = Vec::new();
            let mut visited = vec![vec![false; n]; m];

            for i in 0..m {
                for j in 0..n {
                    if is_infected[i][j] == 1 && !visited[i][j] {
                        let mut region = Vec::new();
                        let mut danger = std::collections::HashSet::new();
                        Self::dfs(&is_infected, &mut visited, i, j, &mut region, &mut danger);
                        regions.push(region);
                        dangers.push(danger);
                    }
                }
            }

            if regions.is_empty() { break; }

            let max_danger_idx = (0..dangers.len()).max_by_key(|&i| dangers[i].len()).unwrap();
            walls += dangers[max_danger_idx].len() as i32;

            for (idx, region) in regions.iter().enumerate() {
                for &(i, j) in region {
                    if idx == max_danger_idx {
                        is_infected[i][j] = -1;
                    } else {
                        for (di, dj) in &[(0, 1), (1, 0), (0, -1), (-1, 0)] {
                            let ni = i as i32 + di;
                            let nj = j as i32 + dj;
                            if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 {
                                let ni = ni as usize;
                                let nj = nj as usize;
                                if is_infected[ni][nj] == 0 {
                                    is_infected[ni][nj] = 1;
                                }
                            }
                        }
                    }
                }
            }
        }

        walls
    }

    fn dfs(
        grid: &Vec<Vec<i32>>,
        visited: &mut Vec<Vec<bool>>,
        i: usize,
        j: usize,
        region: &mut Vec<(usize, usize)>,
        danger: &mut std::collections::HashSet<(usize, usize)>,
    ) {
        let m = grid.len();
        let n = grid[0].len();
        visited[i][j] = true;
        region.push((i, j));

        for (di, dj) in &[(0, 1), (1, 0), (0, -1), (-1, 0)] {
            let ni = i as i32 + di;
            let nj = j as i32 + dj;
            if ni >= 0 && ni < m as i32 && nj >= 0 && nj < n as i32 {
                let ni = ni as usize;
                let nj = nj as usize;
                if grid[ni][nj] == 0 {
                    danger.insert((ni, nj));
                } else if grid[ni][nj] == 1 && !visited[ni][nj] {
                    Self::dfs(grid, visited, ni, nj, region, danger);
                }
            }
        }
    }
}