impl Solution {
    pub fn largest_divisible_subset(mut nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        if n == 0 {
            return Vec::new();
        }

        nums.sort_unstable();

        let mut dp = vec![1; n];
        let mut prev = vec![-1; n];

        let mut max_len = 0;
        let mut max_idx = -1;

        for i in 0..n {
            for j in 0..i {
                if nums[i] % nums[j] == 0 {
                    if dp[j] + 1 > dp[i] {
                        dp[i] = dp[j] + 1;
                        prev[i] = j as isize;
                    }
                }
            }
            if dp[i] > max_len {
                max_len = dp[i];
                max_idx = i as isize;
            }
        }

        let mut result = Vec::new();
        let mut curr_idx = max_idx;
        while curr_idx != -1 {
            result.push(nums[curr_idx as usize]);
            curr_idx = prev[curr_idx as usize];
        }

        result.reverse();
        result
    }
}