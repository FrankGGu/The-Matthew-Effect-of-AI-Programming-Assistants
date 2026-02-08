impl Solution {
    pub fn find_target_sum_ways(nums: Vec<i32>, target: i32) -> i32 {
        let sum_nums: i32 = nums.iter().sum();

        if (target + sum_nums) % 2 != 0 || (target + sum_nums) < 0 {
            return 0;
        }

        let target_sum_p = (target + sum_nums) / 2;

        let mut dp: Vec<i32> = vec![0; (target_sum_p + 1) as usize];
        dp[0] = 1;

        for num in nums {
            for j in (num..=target_sum_p).rev() {
                dp[j as usize] += dp[(j - num) as usize];
            }
        }

        dp[target_sum_p as usize]
    }
}