const MOD: i64 = 1_000_000_007;

impl Solution {
    pub fn number_of_good_subsets(nums: Vec<i32>) -> i32 {
        let primes = vec![2, 3, 5, 7, 11, 13, 17, 19, 23, 29];
        let mut mask_map = std::collections::HashMap::new();
        mask_map.insert(1, 0);
        mask_map.insert(2, 1);
        mask_map.insert(3, 2);
        mask_map.insert(5, 3);
        mask_map.insert(6, 3 | 1);
        mask_map.insert(7, 4);
        mask_map.insert(10, 3 | 1);
        mask_map.insert(11, 5);
        mask_map.insert(13, 6);
        mask_map.insert(14, 4 | 1);
        mask_map.insert(15, 3 | 2);
        mask_map.insert(17, 7);
        mask_map.insert(19, 8);
        mask_map.insert(21, 4 | 2);
        mask_map.insert(22, 5 | 1);
        mask_map.insert(23, 9);
        mask_map.insert(26, 6 | 1);
        mask_map.insert(29, 10);
        mask_map.insert(30, 3 | 1 | 2);

        let mut counts = vec![0; 31];
        let mut one_count = 0;
        for &num in &nums {
            if num == 1 {
                one_count += 1;
            } else if mask_map.contains_key(&num) {
                counts[num as usize] += 1;
            }
        }

        let mut dp = vec![0; 1 << 11];
        dp[0] = 1;

        for i in 2..=30 {
            if counts[i] > 0 && mask_map.contains_key(&(i as i32)) {
                let mask = mask_map[&(i as i32)];
                for j in 0..(1 << 11) {
                    if (j & mask) == 0 {
                        dp[j | mask] = (dp[j | mask] + dp[j] * counts[i]) % MOD;
                    }
                }
            }
        }

        let mut ans = 0;
        for &val in &dp {
            ans = (ans + val) % MOD;
        }

        ans = (ans - 1 + MOD) % MOD;

        for _ in 0..one_count {
            ans = (ans * 2) % MOD;
        }

        ans as i32
    }
}