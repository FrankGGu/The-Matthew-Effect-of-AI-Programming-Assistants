impl Solution {
    pub fn can_divide(nums: Vec<i32>, m: i32) -> bool {
        let total = nums.len();
        let sum: i32 = nums.iter().sum();
        let min_diff = sum / m;
        let mut dp = vec![false; (sum + 1) as usize];
        dp[0] = true;

        for &num in &nums {
            for j in (num..=sum).rev() {
                dp[j as usize] |= dp[(j - num) as usize];
            }
        }

        for i in (min_diff..=sum).rev() {
            if dp[i as usize] {
                return true;
            }
        }
        false
    }
}