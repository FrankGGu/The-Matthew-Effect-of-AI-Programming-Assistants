impl Solution {
    pub fn beautiful_subsets(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = 0;
        let n = nums.len();
        let mut dp = vec![0; n + 1];
        dp[0] = 1;

        for i in 0..n {
            let mut temp = dp.clone();
            for j in 0..=i {
                if (nums[i] - nums[j]).abs() != k {
                    temp[j + 1] += dp[j];
                }
            }
            dp = temp;
        }

        for i in 1..=n {
            count += dp[i];
        }

        count - 1
    }
}