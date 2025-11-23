impl Solution {
    pub fn max_result(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let k = k as usize;
        let mut dp = vec![0; n];
        dp[0] = nums[0];
        let mut deque = std::collections::VecDeque::new();
        deque.push_back(0);

        for i in 1..n {
            while !deque.is_empty() && deque.front().unwrap() + k < i {
                deque.pop_front();
            }
            dp[i] = dp[*deque.front().unwrap()] + nums[i];
            while !deque.is_empty() && dp[i] >= dp[*deque.back().unwrap()] {
                deque.pop_back();
            }
            deque.push_back(i);
        }

        dp[n - 1]
    }
}