impl Solution {
    pub fn largest_island(grid: Vec<Vec<i32>>) -> i32 {
        let (n, m) = (grid.len(), grid[0].len());
        let mut id = 2;
        let mut area = vec![0; n * m + 2];
        let mut directions = vec![(1, 0), (-1, 0), (0, 1), (0, -1)];

        fn dfs(x: usize, y: usize, grid: &mut Vec<Vec<i32>>, id: i32, area: &mut Vec<i32>, n: usize, m: usize) {
            area[id as usize] += 1;
            grid[x][y] = id;
            for (dx, dy) in &directions {
                let (nx, ny) = (x as isize + dx, y as isize + dy);
                if nx >= 0 && nx < n as isize && ny >= 0 && ny < m as isize && grid[nx as usize][ny as usize] == 1 {
                    dfs(nx as usize, ny as usize, grid, id, area, n, m);
                }
            }
        }

        for i in 0..n {
            for j in 0..m {
                if grid[i][j] == 1 {
                    dfs(i, j, &mut grid, id, &mut area, n, m);
                    id += 1;
                }
            }
        }

        let mut max_area = *area.iter().max().unwrap();

        for i in 0..n {
            for j in 0..m {
                if grid[i][j] == 0 {
                    let mut new_area = 1;
                    let mut seen = std::collections::HashSet::new();
                    for (dx, dy) in &directions {
                        let (nx, ny) = (i as isize + dx, j as isize + dy);
                        if nx >= 0 && nx < n as isize && ny >= 0 && ny < m as isize {
                            let neighbor_id = grid[nx as usize][ny as usize];
                            if neighbor_id > 1 && !seen.contains(&neighbor_id) {
                                new_area += area[neighbor_id as usize];
                                seen.insert(neighbor_id);
                            }
                        }
                    }
                    max_area = max_area.max(new_area);
                }
            }
        }

        max_area
    }
}