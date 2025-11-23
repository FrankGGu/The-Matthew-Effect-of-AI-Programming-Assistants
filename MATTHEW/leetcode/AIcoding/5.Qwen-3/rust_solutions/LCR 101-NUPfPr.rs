impl Solution {
    pub fn can_partition(nums: Vec<i32>) -> bool {
        let sum: i32 = nums.iter().sum();
        if sum % 2 != 0 {
            return false;
        }
        let target = sum / 2;
        let mut dp = vec![false; (target + 1) as usize];
        dp[0] = true;
        for num in nums {
            for i in (num as usize..=target as usize).rev() {
                if dp[i - num as usize] {
                    dp[i] = true;
                }
            }
        }
        dp[target as usize]
    }
}