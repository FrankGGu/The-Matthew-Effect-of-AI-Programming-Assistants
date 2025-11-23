use std::collections::VecDeque;

impl Solution {
    pub fn max_result(nums: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let n = nums.len();
        let mut dp = vec![0; n];
        let mut deque = VecDeque::new();
        dp[0] = nums[0];
        deque.push_back(0);

        for i in 1..n {
            while let Some(&front) = deque.front() {
                if front < i.saturating_sub(k) {
                    deque.pop_front();
                } else {
                    break;
                }
            }
            dp[i] = dp[*deque.front().unwrap()] + nums[i];
            while let Some(&back) = deque.back() {
                if dp[back] <= dp[i] {
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