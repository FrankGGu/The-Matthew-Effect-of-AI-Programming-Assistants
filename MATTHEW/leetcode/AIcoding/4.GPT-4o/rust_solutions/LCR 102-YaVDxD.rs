impl Solution {
    pub fn find_target_sum_ways(nums: Vec<i32>, target: i32) -> i32 {
        let sum: i32 = nums.iter().sum();
        if (target + sum) % 2 != 0 || target.abs() > sum {
            return 0;
        }
        let s2 = (target + sum) / 2;
        let mut dp = vec![0; (s2 + 1) as usize];
        dp[0] = 1;

        for num in nums {
            for j in (num..=s2).rev() {
                dp[j as usize] += dp[(j - num) as usize];
            }
        }
        dp[s2 as usize]
    }
}