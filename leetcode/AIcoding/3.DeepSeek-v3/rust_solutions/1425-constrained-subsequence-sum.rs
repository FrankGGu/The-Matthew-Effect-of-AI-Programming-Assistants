use std::collections::VecDeque;

impl Solution {
    pub fn constrained_subset_sum(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let mut dp = vec![0; nums.len()];
        let mut deque = VecDeque::new();
        let mut max_sum = i32::MIN;

        for i in 0..nums.len() {
            if let Some(&front) = deque.front() {
                if front < i - k {
                    deque.pop_front();
                }
            }

            dp[i] = nums[i];
            if let Some(&front) = deque.front() {
                dp[i] += dp[front];
            }
            if dp[i] > 0 {
                while let Some(&back) = deque.back() {
                    if dp[back] <= dp[i] {
                        deque.pop_back();
                    } else {
                        break;
                    }
                }
                deque.push_back(i);
            }

            max_sum = max_sum.max(dp[i]);
        }

        max_sum
    }
}