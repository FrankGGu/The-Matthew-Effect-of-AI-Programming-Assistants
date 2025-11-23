use std::collections::VecDeque;

impl Solution {
    pub fn max_result(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let mut dp = vec![0; n];
        dp[0] = nums[0];
        let mut deque: VecDeque<usize> = VecDeque::new();
        deque.push_back(0);

        for i in 1..n {
            while !deque.is_empty() && *deque.front().unwrap() < i - k {
                deque.pop_front();
            }

            dp[i] = dp[*deque.front().unwrap()] + nums[i];

            while !deque.is_empty() && dp[*deque.back().unwrap()] <= dp[i] {
                deque.pop_back();
            }

            deque.push_back(i);
        }

        dp[n - 1]
    }
}