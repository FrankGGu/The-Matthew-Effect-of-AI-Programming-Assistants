struct Solution;

impl Solution {
    pub fn color_border(mut grid: Vec<Vec<i32>>, r0: i32, c0: i32, color: i32) -> Vec<Vec<i32>> {
        let m = grid.len();
        let n = grid[0].len();
        let original_color = grid[r0 as usize][c0 as usize];

        let mut visited = vec![vec![false; n]; m];
        let mut border_cells = Vec::new();

        let dr = [-1, 1, 0, 0];
        let dc = [0, 0, -1, 1];

        fn dfs(
            r: usize,
            c: usize,
            original_color: i32,
            m: usize,
            n: usize,
            grid: &Vec<Vec<i32>>,
            visited: &mut Vec<Vec<bool>>,
            border_cells: &mut Vec<(usize, usize)>,
            dr: &[i32],
            dc: &[i32],
        ) {
            visited[r][c] = true;

            let mut connected_neighbors = 0;

            for i in 0..4 {
                let nr = r as i32 + dr[i];
                let nc = c as i32 + dc[i];

                if nr < 0 || nr >= m as i32 || nc < 0 || nc >= n as i32 {
                    // Neighbor is out of bounds, so current cell is a border cell
                    continue;
                }

                let nr_usize = nr as usize;
                let nc_usize = nc as usize;

                if grid[nr_usize][nc_usize] == original_color {
                    connected_neighbors += 1;
                    if !visited[nr_usize][nc_usize] {
                        dfs(nr_usize, nc_usize, original_color, m, n, grid, visited, border_cells, dr, dc);
                    }
                }
            }

            // A cell is a border cell if it has fewer than 4 neighbors that are
            // part of the same connected component (i.e., same original_color and in bounds).
            if connected_neighbors < 4 {
                border_cells.push((r, c));
            }
        }

        dfs(r0 as usize, c0 as usize, original_color, m, n, &grid, &mut visited, &mut border_cells, &dr, &dc);

        for &(r, c) in border_cells.iter() {
            grid[r][c] = color;
        }

        grid
    }
}