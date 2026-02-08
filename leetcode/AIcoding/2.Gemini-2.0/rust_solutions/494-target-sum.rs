impl Solution {
    pub fn find_target_sum_ways(nums: Vec<i32>, target: i32) -> i32 {
        let sum: i32 = nums.iter().sum();
        if (sum - target) % 2 != 0 || target > sum {
            return 0;
        }
        let p = (sum - target) / 2;
        if p < 0 {
            return 0;
        }
        let mut dp = vec![0; (p + 1) as usize];
        dp[0] = 1;

        for &num in &nums {
            for j in (num..=p).rev() {
                dp[j as usize] += dp[(j - num) as usize];
            }
        }

        dp[p as usize]
    }
}