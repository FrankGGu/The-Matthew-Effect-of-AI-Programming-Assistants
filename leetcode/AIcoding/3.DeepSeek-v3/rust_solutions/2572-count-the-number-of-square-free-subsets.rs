impl Solution {
    pub fn square_free_subsets(nums: Vec<i32>) -> i32 {
        const MOD: i64 = 1_000_000_007;
        const PRIMES: [i32; 10] = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
        let mut dp = vec![0; 1 << 10];
        dp[0] = 1;

        for num in nums {
            if num == 1 {
                dp[0] = (dp[0] * 2) % MOD;
                continue;
            }
            let mut mask = 0;
            let mut valid = true;
            for (i, &p) in PRIMES.iter().enumerate() {
                let mut cnt = 0;
                let mut x = num;
                while x % p == 0 {
                    x /= p;
                    cnt += 1;
                }
                if cnt >= 2 {
                    valid = false;
                    break;
                }
                if cnt == 1 {
                    mask |= 1 << i;
                }
            }
            if !valid {
                continue;
            }
            for i in (0..1 << 10).rev() {
                if (i & mask) == 0 {
                    let new_mask = i | mask;
                    dp[new_mask] = (dp[new_mask] + dp[i]) % MOD;
                }
            }
        }

        let mut res = 0;
        for &count in dp.iter() {
            res = (res + count) % MOD;
        }
        res = (res - 1 + MOD) % MOD;
        res as i32
    }
}