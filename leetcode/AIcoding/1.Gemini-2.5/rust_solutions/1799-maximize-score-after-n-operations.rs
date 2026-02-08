impl Solution {
    fn gcd(a: i32, b: i32) -> i32 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }

    pub fn max_score(nums: Vec<i32>) -> i32 {
        let m = nums.len();
        let n = m / 2;

        let mut dp = vec![0; 1 << m];

        for mask in 0..(1 << m) {
            let bits_count = mask.count_ones() as usize;

            if bits_count % 2 != 0 {
                continue;
            }

            let current_op = bits_count / 2 + 1;

            if current_op > n {
                continue;
            }

            let mut i = 0;
            while i < m && (mask & (1 << i)) != 0 {
                i += 1;
            }

            for j in (i + 1)..m {
                if (mask & (1 << j)) == 0 {
                    let next_mask = mask | (1 << i) | (1 << j);
                    let score = current_op as i32 * Self::gcd(nums[i], nums[j]);
                    dp[next_mask] = dp[next_mask].max(dp[mask] + score);
                }
            }
        }

        dp[(1 << m) - 1]
    }
}