impl Solution {
    pub fn sum_of_floored_pairs(nums: Vec<i32>) -> i32 {
        const MOD: i64 = 1_000_000_007;
        let max_num = *nums.iter().max().unwrap_or(&0) as usize;
        let mut freq = vec![0; max_num + 1];
        let mut prefix = vec![0; max_num + 1];

        for &num in &nums {
            freq[num as usize] += 1;
        }

        for i in 1..=max_num {
            prefix[i] = prefix[i - 1] + freq[i];
        }

        let mut res = 0;
        for y in 1..=max_num {
            if freq[y] == 0 {
                continue;
            }
            for q in 1..=(max_num / y) {
                let lower = q * y;
                let upper = (q + 1) * y - 1;
                let upper = upper.min(max_num);
                if lower > max_num {
                    break;
                }
                let count = prefix[upper] - prefix[lower - 1];
                res += freq[y] as i64 * q as i64 * count as i64;
                res %= MOD;
            }
        }

        res as i32
    }
}