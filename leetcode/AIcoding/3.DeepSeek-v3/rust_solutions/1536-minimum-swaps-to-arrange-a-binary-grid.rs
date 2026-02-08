impl Solution {
    pub fn min_swaps(grid: Vec<Vec<i32>>) -> i32 {
        let n = grid.len();
        let mut zeros = vec![0; n];

        for i in 0..n {
            let mut cnt = 0;
            for j in (0..n).rev() {
                if grid[i][j] == 0 {
                    cnt += 1;
                } else {
                    break;
                }
            }
            zeros[i] = cnt;
        }

        let mut res = 0;
        for i in 0..n {
            let required = n - i - 1;
            if zeros[i] >= required {
                continue;
            }
            let mut found = false;
            for j in i + 1..n {
                if zeros[j] >= required {
                    found = true;
                    res += (j - i) as i32;
                    zeros[i + 1..=j].rotate_left(1);
                    break;
                }
            }
            if !found {
                return -1;
            }
        }
        res
    }
}