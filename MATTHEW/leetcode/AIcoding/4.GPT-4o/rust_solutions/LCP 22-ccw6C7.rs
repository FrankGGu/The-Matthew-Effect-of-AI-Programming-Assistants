impl Solution {
    pub fn color_the_grid(m: i32, n: i32) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let n = n as usize;
        let m = m as usize;
        let mut dp = vec![vec![0; 1 << (2 * m)]; n + 1];
        dp[0][0] = 1;

        for i in 0..n {
            for mask in 0..(1 << (2 * m)) {
                if dp[i][mask] == 0 { continue; }
                let used = (0..m).map(|j| (mask >> (2 * j) & 3) as u8).collect::<Vec<_>>();
                let mut next_mask = vec![0; 1 << (2 * m)];
                for new_mask in 0..(1 << (2 * m)) {
                    let mut valid = true;
                    for j in 0..m {
                        if (new_mask >> (2 * j) & 3) == (used[j] & 3) {
                            valid = false;
                            break;
                        }
                    }
                    if valid {
                        let mut count = 1;
                        for j in 0..m {
                            let c = (new_mask >> (2 * j) & 3) as u8;
                            if c != 0 {
                                count += 1;
                            }
                        }
                        next_mask[new_mask] = (next_mask[new_mask] + dp[i][mask] * count) % MOD;
                    }
                }
                for j in 0..(1 << (2 * m)) {
                    dp[i + 1][j] = (dp[i + 1][j] + next_mask[j]) % MOD;
                }
            }
        }

        dp[n][0]
    }
}