impl Solution {
    pub fn max_students(seats: Vec<Vec<char>>) -> i32 {
        let m = seats.len();
        let n = seats[0].len();
        let mut dp = vec![vec![-1; 1 << n]; m + 1];
        dp[0][0] = 0;

        for i in 1..=m {
            for mask in 0..(1 << n) {
                let mut valid = true;
                let mut count = 0;

                for j in 0..n {
                    if (mask & (1 << j)) != 0 {
                        if seats[i - 1][j] == '#' {
                            valid = false;
                            break;
                        }
                        if j > 0 && (mask & (1 << (j - 1))) != 0 {
                            valid = false;
                            break;
                        }
                        count += 1;
                    }
                }

                if !valid {
                    continue;
                }

                for prev_mask in 0..(1 << n) {
                    if dp[i - 1][prev_mask] == -1 {
                        continue;
                    }

                    let mut compatible = true;
                    for j in 0..n {
                        if (mask & (1 << j)) != 0 {
                            if j > 0 && (prev_mask & (1 << (j - 1))) != 0 {
                                compatible = false;
                                break;
                            }
                            if j < n - 1 && (prev_mask & (1 << (j + 1))) != 0 {
                                compatible = false;
                                break;
                            }
                        }
                    }

                    if compatible {
                        dp[i][mask] = dp[i][mask].max(dp[i - 1][prev_mask] + count);
                    }
                }
            }
        }

        let mut ans = 0;
        for mask in 0..(1 << n) {
            ans = ans.max(dp[m][mask]);
        }

        ans
    }
}