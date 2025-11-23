use std::collections::VecDeque;

impl Solution {
    pub fn constrained_subset_sum(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut dp = vec![0; n];
        let mut deque: VecDeque<usize> = VecDeque::new();

        dp[0] = nums[0];
        deque.push_back(0);
        let mut max_sum = dp[0];

        for i in 1..n {
            let window_start_idx = i.saturating_sub(k as usize);

            while let Some(&front_idx) = deque.front() {
                if front_idx < window_start_idx {
                    deque.pop_front();
                } else {
                    break;
                }
            }

            let prev_max_dp_val = if let Some(&front_idx) = deque.front() {
                dp[front_idx]
            } else {
                0
            };

            dp[i] = nums[i] + prev_max_dp_val.max(0);

            max_sum = max_sum.max(dp[i]);

            while let Some(&back_idx) = deque.back() {
                if dp[back_idx] <= dp[i] {
                    deque.pop_back();
                } else {
                    break;
                }
            }

            deque.push_back(i);
        }

        max_sum
    }
}