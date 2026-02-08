impl Solution {
    pub fn square_free_subsets(nums: Vec<i32>) -> i32 {
        const MOD: i32 = 1_000_000_007;
        let mut count = vec![0; 10001];
        let mut square_free_mask = vec![0; 10001];

        for &num in &nums {
            count[num as usize] += 1;
        }

        for i in 1..=10000 {
            if count[i] > 0 {
                let mut mask = 0;
                for j in (1..=i).filter(|&j| i % j == 0 && j * j == i) {
                    mask |= 1 << (j as usize);
                }
                square_free_mask[i] = mask;
            }
        }

        let mut dp = vec![0; 1 << 10];
        dp[0] = 1;

        for i in 1..=10000 {
            if count[i] == 0 {
                continue;
            }
            let mut new_dp = dp.clone();
            for j in 0..(1 << 10) {
                if j & square_free_mask[i] == 0 {
                    new_dp[j | square_free_mask[i]] = (new_dp[j | square_free_mask[i]] + dp[j] * count[i]) % MOD;
                }
            }
            dp = new_dp;
        }

        let mut result = 0;
        for j in 1..(1 << 10) {
            result = (result + dp[j]) % MOD;
        }

        result
    }
}