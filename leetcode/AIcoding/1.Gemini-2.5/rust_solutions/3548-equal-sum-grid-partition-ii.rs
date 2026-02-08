struct Solution;

impl Solution {
    pub fn equal_sum_grid_partition_ii(grid: Vec<Vec<i32>>) -> bool {
        let m = grid.len();
        let n = grid[0].len();

        let mut prefix_sum = vec![vec![0; n + 1]; m + 1];
        for r in 0..m {
            for c in 0..n {
                prefix_sum[r + 1][c + 1] = grid[r][c]
                    + prefix_sum[r][c + 1]
                    + prefix_sum[r + 1][c]
                    - prefix_sum[r][c];
            }
        }

        let get_sum = |r1: usize, c1: usize, r2: usize, c2: usize| -> i32 {
            if r1 > r2 || c1 > c2 {
                return 0;
            }
            prefix_sum[r2 + 1][c2 + 1]
                - prefix_sum[r1][c2 + 1]
                - prefix_sum[r2 + 1][c1]
                + prefix_sum[r1][c1]
        };

        for r1_cut_idx in 1..m - 2 {
            for r2_cut_idx in (r1_cut_idx + 1)..m - 1 {
                for c1_cut_idx in 1..n - 2 {
                    for c2_cut_idx in (c1_cut_idx + 1)..n - 1 {
                        let sum1 = get_sum(0, 0, r1_cut_idx - 1, c1_cut_idx - 1);
                        let sum2 = get_sum(0, c2_cut_idx, r1_cut_idx - 1, n - 1);
                        let sum3 = get_sum(r2_cut_idx, 0, m - 1, c1_cut_idx - 1);
                        let sum4 = get_sum(r2_cut_idx, c2_cut_idx, m - 1, n - 1);

                        if sum1 == sum2 && sum1 == sum3 && sum1 == sum4 {
                            return true;
                        }
                    }
                }
            }
        }

        false
    }
}