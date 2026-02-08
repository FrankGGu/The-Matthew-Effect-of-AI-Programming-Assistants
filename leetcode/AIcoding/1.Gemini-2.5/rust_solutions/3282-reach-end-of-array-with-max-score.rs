use std::collections::VecDeque;

impl Solution {
    pub fn max_result(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k_usize = k as usize;
        let mut dp = vec![0; n];
        let mut deque: VecDeque<usize> = VecDeque::new();

        dp[0] = nums[0];
        deque.push_back(0);

        for i in 1..n {
            while let Some(&front_idx) = deque.front() {
                if front_idx < i - k_usize {
                    deque.pop_front();
                } else {
                    break;
                }
            }

            if let Some(&max_prev_idx) = deque.front() {
                dp[i] = nums[i] + dp[max_prev_idx];
            } else {
                dp[i] = nums[i]; 
            }

            while let Some(&back_idx) = deque.back() {
                if dp[back_idx] <= dp[i] {
                    deque.pop_back();
                } else {
                    break;
                }
            }

            deque.push_back(i);
        }

        dp[n - 1]
    }
}