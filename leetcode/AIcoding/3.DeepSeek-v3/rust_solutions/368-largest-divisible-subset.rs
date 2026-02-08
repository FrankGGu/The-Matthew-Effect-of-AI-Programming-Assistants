impl Solution {
    pub fn largest_divisible_subset(nums: Vec<i32>) -> Vec<i32> {
        if nums.is_empty() {
            return vec![];
        }
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut dp = vec![1; n];
        let mut prev = vec![-1; n];
        let mut max_len = 1;
        let mut max_idx = 0;

        for i in 1..n {
            for j in 0..i {
                if nums[i] % nums[j] == 0 && dp[i] < dp[j] + 1 {
                    dp[i] = dp[j] + 1;
                    prev[i] = j as i32;
                }
            }
            if dp[i] > max_len {
                max_len = dp[i];
                max_idx = i;
            }
        }

        let mut res = Vec::new();
        let mut idx = max_idx as i32;
        while idx != -1 {
            res.push(nums[idx as usize]);
            idx = prev[idx as usize];
        }
        res
    }
}