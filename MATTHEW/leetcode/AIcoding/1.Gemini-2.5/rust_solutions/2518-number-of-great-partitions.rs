impl Solution {
    pub fn count_great_partitions(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k_long = k as i64;
        let modulo: i64 = 1_000_000_007;

        let mut total_sum: i64 = 0;
        for &num in &nums {
            total_sum += num as i64;
        }

        if total_sum < 2 * k_long {
            return 0;
        }

        let mut dp: Vec<i64> = vec![0; (total_sum + 1) as usize];
        dp[0] = 1;

        for &num_val in &nums {
            let num = num_val as i64;
            for s in (num..=total_sum).rev() {
                dp[s as usize] = (dp[s as usize] + dp[(s - num) as usize]) % modulo;
            }
        }

        let mut count_small_sum: i64 = 0;
        for s in 0..k_long {
            if s > total_sum {
                break;
            }
            count_small_sum = (count_small_sum + dp[s as usize]) % modulo;
        }

        let mut total_subsets_count: i64 = 1;
        for _ in 0..n {
            total_subsets_count = (total_subsets_count * 2) % modulo;
        }

        let bad_partitions_count = (2 * count_small_sum) % modulo;

        let result = (total_subsets_count - bad_partitions_count + modulo) % modulo;
        result as i32
    }
}