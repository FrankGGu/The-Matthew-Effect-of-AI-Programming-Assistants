impl Solution {
    pub fn largest_divisible_subset(nums: Vec<i32>) -> Vec<i32> {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut dp = vec![1; n];
        let mut prev = vec![-1; n];
        let mut max_len = 1;
        let mut max_index = 0;

        for i in 1..n {
            for j in 0..i {
                if nums[i] % nums[j] == 0 {
                    if dp[i] < dp[j] + 1 {
                        dp[i] = dp[j] + 1;
                        prev[i] = j as i32;
                    }
                }
            }
            if dp[i] > max_len {
                max_len = dp[i];
                max_index = i;
            }
        }

        let mut result = Vec::new();
        let mut current = max_index as i32;
        while current != -1 {
            result.push(nums[current as usize]);
            current = prev[current as usize];
        }
        result
    }
}