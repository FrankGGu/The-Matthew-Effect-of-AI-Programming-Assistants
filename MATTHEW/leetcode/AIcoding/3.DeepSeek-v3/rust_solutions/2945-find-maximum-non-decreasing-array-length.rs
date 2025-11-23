impl Solution {
    pub fn find_maximum_length(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut prefix = vec![0; n + 1];
        for i in 0..n {
            prefix[i + 1] = prefix[i] + nums[i];
        }
        let mut dp = vec![0; n + 1];
        let mut last = vec![0; n + 1];
        let mut q = std::collections::VecDeque::new();
        q.push_back(0);
        for i in 1..=n {
            while q.len() >= 2 && prefix[*q.front().unwrap()] + last[*q.front().unwrap()] <= prefix[i] {
                q.pop_front();
            }
            if let Some(&j) = q.front() {
                dp[i] = dp[j] + 1;
                last[i] = prefix[i] - prefix[j];
            }
            while !q.is_empty() && prefix[*q.back().unwrap()] + last[*q.back().unwrap()] >= prefix[i] + last[i] {
                q.pop_back();
            }
            q.push_back(i);
        }
        dp[n]
    }
}