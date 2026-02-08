use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn contain_virus(mut grid: Vec<Vec<i32>>) -> i32 {
        let rows = grid.len();
        if rows == 0 {
            return 0;
        }
        let cols = grid[0].len();
        if cols == 0 {
            return 0;
        }

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        let mut total_walls = 0;

        loop {
            let mut visited = vec![vec![false; cols]; rows];
            let mut regions_data: Vec<(usize, i32, Vec<(usize, usize)>, HashSet<(usize, usize)>)> = Vec::new();

            for r in 0..rows {
                for c in 0..cols {
                    if grid[r][c] == 1 && !visited[r][c] {
                        let mut current_region_cells: Vec<(usize, usize)> = Vec::new();
                        let mut current_region_threatened_cells: HashSet<(usize, usize)> = HashSet::new();
                        let mut current_region_walls = 0;

                        let mut q = vec![(r, c)];
                        visited[r][c] = true;
                        current_region_cells.push((r, c));

                        let mut head = 0;
                        while head < q.len() {
                            let (curr_r, curr_c) = q[head];
                            head += 1;

                            for i in 0..4 {
                                let nr = (curr_r as isize + dr[i]) as usize;
                                let nc = (curr_c as isize + dc[i]) as usize;

                                if nr < rows && nc < cols {
                                    if grid[nr][nc] == 1 && !visited[nr][nc] {
                                        visited[nr][nc] = true;
                                        q.push((nr, nc));
                                        current_region_cells.push((nr, nc));
                                    } else if grid[nr][nc] == 0 {
                                        current_region_walls += 1;
                                        current_region_threatened_cells.insert((nr, nc));
                                    }
                                }
                            }
                        }

                        if !current_region_threatened_cells.is_empty() {
                            regions_data.push((
                                current_region_threatened_cells.len(),
                                current_region_walls,
                                current_region_cells,
                                current_region_threatened_cells,
                            ));
                        }
                    }
                }
            }

            if regions_data.is_empty() {
                break;
            }

            let mut best_region_idx = 0;
            let mut max_threatened = 0;
            for i in 0..regions_data.len() {
                if regions_data[i].0 > max_threatened {
                    max_threatened = regions_data[i].0;
                    best_region_idx = i;
                }
            }

            if max_threatened == 0 {
                break;
            }

            total_walls += regions_data[best_region_idx].1;

            for &(r, c) in &regions_data[best_region_idx].2 {
                grid[r][c] = 2;
            }

            for i in 0..regions_data.len() {
                if i == best_region_idx {
                    continue;
                }
                for &(r, c) in &regions_data[i].3 {
                    grid[r][c] = 1;
                }
            }
        }

        total_walls
    }
}