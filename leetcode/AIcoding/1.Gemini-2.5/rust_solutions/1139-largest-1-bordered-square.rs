impl Solution {
    pub fn largest_1_bordered_square(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        if m == 0 {
            return 0;
        }
        let n = grid[0].len();
        if n == 0 {
            return 0;
        }

        let mut right = vec![vec![0; n]; m];
        let mut down = vec![vec![0; n]; m];

        for i in (0..m).rev() {
            for j in (0..n).rev() {
                if grid[i][j] == 1 {
                    right[i][j] = 1 + if j + 1 < n { right[i][j + 1] } else { 0 };
                    down[i][j] = 1 + if i + 1 < m { down[i + 1][j] } else { 0 };
                }
            }
        }

        let mut max_side = 0;

        for i in 0..m {
            for j in 0..n {
                let max_k_for_current_cell = std::cmp::min(right[i][j], down[i][j]);

                for k in (1..=max_k_for_current_cell).rev() {
                    if k <= max_side {
                        break; 
                    }

                    if right[i + k - 1][j] >= k && down[i][j + k - 1] >= k {
                        max_side = std::cmp::max(max_side, k);
                        break; 
                    }
                }
            }
        }

        max_side * max_side
    }
}