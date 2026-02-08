impl Solution {
    pub fn can_partition(nums: Vec<i32>) -> bool {
        let total: i32 = nums.iter().sum();
        if total % 2 != 0 {
            return false;
        }
        let target = total / 2;
        let n = nums.len();
        let mut dp = vec![false; (target + 1) as usize];
        dp[0] = true;

        for num in nums {
            for j in (num..=target).rev() {
                dp[j as usize] = dp[j as usize] || dp[(j - num) as usize];
            }
        }

        dp[target as usize]
    }
}