impl Solution {
    pub fn contain_virus(infected: Vec<Vec<i32>>) -> i32 {
        let mut grid = infected;
        let m = grid.len();
        let n = grid[0].len();
        let mut ans = 0;

        while true {
            let mut regions = Vec::new();
            let mut visited = vec![vec![false; n]; m];

            for i in 0..m {
                for j in 0..n {
                    if grid[i][j] == 1 && !visited[i][j] {
                        let mut region = Vec::new();
                        let mut walls = 0;
                        let mut threat = std::collections::HashSet::new();
                        Self::dfs(&mut grid, i, j, &mut visited, &mut region, &mut walls, &mut threat);
                        regions.push((region, walls, threat));
                    }
                }
            }

            if regions.is_empty() {
                break;
            }

            regions.sort_by_key(|(_, _, threat)| -(threat.len() as i32));

            let (strongest_region, walls, threat) = regions.remove(0);
            ans += walls;

            for (r, c) in strongest_region {
                grid[r][c] = -1;
            }

            for i in 0..regions.len() {
                let (region, _, threat) = &regions[i];
                for &(r, c) in threat {
                    grid[r][c] = 1;
                }
            }
        }

        ans
    }

    fn dfs(grid: &mut Vec<Vec<i32>>, r: usize, c: usize, visited: &mut Vec<Vec<bool>>, region: &mut Vec<(usize, usize)>, walls: &mut i32, threat: &mut std::collections::HashSet<(usize, usize)>) {
        if r < 0 || r >= grid.len() || c < 0 || c >= grid[0].len() || visited[r][c] || grid[r][c] == -1 {
            return;
        }

        if grid[r][c] == 0 {
            *walls += 1;
            threat.insert((r, c));
            return;
        }

        visited[r][c] = true;
        region.push((r, c));

        Self::dfs(grid, r.wrapping_sub(1), c, visited, region, walls, threat);
        Self::dfs(grid, r + 1, c, visited, region, walls, threat);
        Self::dfs(grid, r, c.wrapping_sub(1), visited, region, walls, threat);
        Self::dfs(grid, r, c + 1, visited, region, walls, threat);
    }
}