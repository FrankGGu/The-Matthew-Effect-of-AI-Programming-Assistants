impl Solution {
    pub fn max_size_slices(slices: Vec<i32>) -> i32 {
        let n = slices.len() / 3;

        fn solve(arr: &[i32], k: usize) -> i32 {
            let m = arr.len();
            let mut dp = vec![vec![i32::MIN; k + 1]; m];

            for j in 0..m {
                dp[j][0] = 0;
            }

            if k >= 1 {
                dp[0][1] = arr[0];
            }

            for j in 1..m {
                for p in 1..=k {
                    dp[j][p] = dp[j-1][p];

                    let mut val_if_picked = arr[j];

                    if p > 1 {
                        if j >= 2 && dp[j-2][p-1] != i32::MIN {
                            val_if_picked += dp[j-2][p-1];
                        } else {
                            val_if_picked = i32::MIN;
                        }
                    }

                    dp[j][p] = dp[j][p].max(val_if_picked);
                }
            }

            dp[m-1][k]
        }

        let res1 = solve(&slices[0..slices.len()-1], n);
        let res2 = solve(&slices[1..slices.len()], n);

        res1.max(res2)
    }
}