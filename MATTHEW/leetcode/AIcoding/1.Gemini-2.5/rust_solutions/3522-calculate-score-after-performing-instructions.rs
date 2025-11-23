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
            while let Some(&front_idx) = deque.front() {
                if front_idx < i - k {
                    deque.pop_front();
                } else {
                    break;
                }
            }

            dp[i] = nums[i] + dp[*deque.front().unwrap()];

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