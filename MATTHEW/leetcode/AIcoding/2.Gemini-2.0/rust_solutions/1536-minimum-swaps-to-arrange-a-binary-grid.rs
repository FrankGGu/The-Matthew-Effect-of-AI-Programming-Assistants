impl Solution {
    pub fn min_swaps(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut rows = vec![0; n];
        for i in 0..n {
            let mut count = 0;
            for j in (0..n).rev() {
                if grid[i][j] == 0 {
                    count += 1;
                } else {
                    break;
                }
            }
            rows[i] = count;
        }

        let mut swaps = 0;
        for i in 0..n {
            let required = n - 1 - i;
            if rows[i] >= required as i32 {
                continue;
            }

            let mut j = i + 1;
            while j < n && rows[j] < required as i32 {
                j += 1;
            }

            if j == n {
                return -1;
            }

            for k in (i..j).rev() {
                rows.swap(k, k + 1);
                swaps += 1;
            }
        }

        swaps
    }
}