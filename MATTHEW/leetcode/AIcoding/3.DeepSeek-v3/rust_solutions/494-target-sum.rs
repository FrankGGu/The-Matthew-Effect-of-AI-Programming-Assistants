impl Solution {
    pub fn find_target_sum_ways(nums: Vec<i32>, target: i32) -> i32 {
        let sum: i32 = nums.iter().sum();
        if target.abs() > sum || (sum + target) % 2 != 0 {
            return 0;
        }
        let s = (sum + target) as usize / 2;
        let mut dp = vec![0; s + 1];
        dp[0] = 1;
        for num in nums {
            for j in (num as usize..=s).rev() {
                dp[j] += dp[j - num as usize];
            }
        }
        dp[s]
    }
}