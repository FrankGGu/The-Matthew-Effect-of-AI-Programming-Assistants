impl Solution {
    pub fn rob(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }
        if n == 1 {
            return nums[0];
        }
        if n == 2 {
            return nums[0].max(nums[1]);
        }

        let mut dp1 = vec![0; n];
        dp1[0] = nums[0];
        dp1[1] = nums[0].max(nums[1]);
        for i in 2..n - 1 {
            dp1[i] = dp1[i - 1].max(dp1[i - 2] + nums[i]);
        }

        let mut dp2 = vec![0; n];
        dp2[1] = nums[1];
        for i in 2..n {
            dp2[i] = dp2[i - 1].max(dp2[i - 2] + nums[i]);
        }

        dp1[n - 2].max(dp2[n - 1])
    }
}