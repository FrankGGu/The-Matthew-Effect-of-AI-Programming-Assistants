impl Solution {
    pub fn delete_and_earn(nums: Vec<i32>) -> i32 {
        let max_num = *nums.iter().max().unwrap();
        let mut earnings = vec![0; (max_num + 1) as usize];

        for &num in &nums {
            earnings[num as usize] += num;
        }

        let mut dp = vec![0; (max_num + 1) as usize];
        dp[1] = earnings[1];

        for i in 2..=max_num as usize {
            dp[i] = dp[i - 1].max(dp[i - 2] + earnings[i]);
        }

        dp[max_num as usize]
    }
}