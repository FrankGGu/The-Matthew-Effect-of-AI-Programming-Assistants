impl Solution {
    pub fn max_trailing_zeros(grid: Vec<Vec<i32>>) -> i32 {
        let m = grid.len();
        let n = grid[0].len();
        let mut prefix2 = vec![vec![0; n + 1]; m + 1];
        let mut prefix5 = vec![vec![0; n + 1]; m + 1];
        let mut left2 = vec![vec![0; n + 1]; m + 1];
        let mut left5 = vec![vec![0; n + 1]; m + 1];
        let mut up2 = vec![vec![0; n + 1]; m + 1];
        let mut up5 = vec![vec![0; n + 1]; m + 1];

        for i in 1..=m {
            for j in 1..=n {
                let mut num = grid[i - 1][j - 1];
                let mut cnt2 = 0;
                let mut cnt5 = 0;
                while num % 2 == 0 {
                    cnt2 += 1;
                    num /= 2;
                }
                while num % 5 == 0 {
                    cnt5 += 1;
                    num /= 5;
                }
                prefix2[i][j] = prefix2[i - 1][j] + prefix2[i][j - 1] - prefix2[i - 1][j - 1] + cnt2;
                prefix5[i][j] = prefix5[i - 1][j] + prefix5[i][j - 1] - prefix5[i - 1][j - 1] + cnt5;
                left2[i][j] = left2[i][j - 1] + cnt2;
                left5[i][j] = left5[i][j - 1] + cnt5;
                up2[i][j] = up2[i - 1][j] + cnt2;
                up5[i][j] = up5[i - 1][j] + cnt5;
            }
        }

        let mut max_zeros = 0;
        for i in 1..=m {
            for j in 1..=n {
                let total2 = prefix2[m][j] + prefix2[i][n] - prefix2[i][j];
                let total5 = prefix5[m][j] + prefix5[i][n] - prefix5[i][j];
                let zeros = total2.min(total5);
                if zeros > max_zeros {
                    max_zeros = zeros;
                }
                let left_up2 = left2[i][j] + up2[i - 1][j];
                let left_up5 = left5[i][j] + up5[i - 1][j];
                let zeros = left_up2.min(left_up5);
                if zeros > max_zeros {
                    max_zeros = zeros;
                }
                let left_down2 = left2[i][j] + (up2[m][j] - up2[i][j]);
                let left_down5 = left5[i][j] + (up5[m][j] - up5[i][j]);
                let zeros = left_down2.min(left_down5);
                if zeros > max_zeros {
                    max_zeros = zeros;
                }
                let right_up2 = (left2[i][n] - left2[i][j - 1]) + up2[i - 1][j];
                let right_up5 = (left5[i][n] - left5[i][j - 1]) + up5[i - 1][j];
                let zeros = right_up2.min(right_up5);
                if zeros > max_zeros {
                    max_zeros = zeros;
                }
                let right_down2 = (left2[i][n] - left2[i][j - 1]) + (up2[m][j] - up2[i][j]);
                let right_down5 = (left5[i][n] - left5[i][j - 1]) + (up5[m][j] - up5[i][j]);
                let zeros = right_down2.min(right_down5);
                if zeros > max_zeros {
                    max_zeros = zeros;
                }
            }
        }
        max_zeros
    }
}