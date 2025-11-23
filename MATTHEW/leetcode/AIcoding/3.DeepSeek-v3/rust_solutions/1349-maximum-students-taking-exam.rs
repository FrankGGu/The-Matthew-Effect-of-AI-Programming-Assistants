impl Solution {
    pub fn max_students(seats: Vec<Vec<char>>) -> i32 {
        let m = seats.len();
        let n = seats[0].len();
        let mut dp = vec![vec![-1; 1 << n]; m + 1];
        dp[0][0] = 0;

        for i in 1..=m {
            for mask in 0..(1 << n) {
                if dp[i - 1][mask] == -1 {
                    continue;
                }
                let mut new_mask = 0;
                for j in 0..n {
                    if seats[i - 1][j] == '.' && (mask & (1 << j)) == 0 {
                        if (j > 0 && (new_mask & (1 << (j - 1))) != 0 {
                            continue;
                        }
                        if j < n - 1 && (new_mask & (1 << (j + 1))) != 0 {
                            continue;
                        }
                        new_mask |= 1 << j;
                    }
                }
                for k in (0..=new_mask).rev() {
                    if (k & new_mask) == k {
                        let cnt = k.count_ones() as i32;
                        if dp[i][k] < dp[i - 1][mask] + cnt {
                            dp[i][k] = dp[i - 1][mask] + cnt;
                        }
                    }
                }
            }
        }

        *dp[m].iter().max().unwrap()
    }
}