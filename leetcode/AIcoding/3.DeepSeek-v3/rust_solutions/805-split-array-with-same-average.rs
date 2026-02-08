impl Solution {
    pub fn split_array_same_average(nums: Vec<i32>) -> bool {
        let n = nums.len();
        if n == 1 {
            return false;
        }
        let sum: i32 = nums.iter().sum();
        let mut dp = vec![0; sum as usize + 1];
        dp[0] = 1;
        for num in nums {
            for s in (num as usize..=sum as usize).rev() {
                dp[s] |= dp[s - num as usize] << 1;
            }
        }
        for k in 1..n {
            if sum * k as i32 % n as i32 == 0 {
                let target = sum * k as i32 / n as i32;
                if target >= 0 && target <= sum && (dp[target as usize] & (1 << k)) != 0 {
                    return true;
                }
            }
        }
        false
    }
}