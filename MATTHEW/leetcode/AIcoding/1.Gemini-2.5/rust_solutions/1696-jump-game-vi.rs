use std::collections::VecDeque;

impl Solution {
    pub fn max_result(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();

        // dp[i] will store the maximum score to reach index i.
        let mut dp = vec![0; n];
        // The deque stores (score, index) pairs, maintaining scores in decreasing order.
        // It helps to efficiently find the maximum dp value in the sliding window [i-k, i-1].
        let mut deque: VecDeque<(i32, usize)> = VecDeque::new();

        // Base case: To reach index 0, the score is just nums[0].
        dp[0] = nums[0];
        deque.push_back((dp[0], 0));

        // Iterate from the second element to the last.
        for i in 1..n {
            // 1. Remove elements from the front of the deque whose indices are no longer
            // within the valid jump range [i-k, i-1].
            // The minimum valid index to jump from to reach 'i' is max(0, i-k).
            let min_idx_in_window = (i as i32 - k).max(0) as usize;
            while let Some((_, idx)) = deque.front() {
                if *idx < min_idx_in_window {
                    deque.pop_front();
                } else {
                    break;
                }
            }

            // 2. The maximum score from a previous valid index is now at the front of the deque.
            // The deque will not be empty here because (i-1) is always a valid previous index
            // (since i > 0), and dp[i-1] would have been added to the deque.
            let max_prev_dp = deque.front().unwrap().0;

            // 3. Calculate dp[i]: current number + maximum score from a previous reachable index.
            dp[i] = nums[i] + max_prev_dp;

            // 4. Remove elements from the back of the deque whose scores are less than or equal to dp[i].
            // This is because dp[i] is a better or equally good option for future jumps,
            // and it's at a later index 'i'. So, any smaller or equal scores at earlier indices
            // are "dominated" by dp[i] and will not be chosen.
            while let Some((val, _)) = deque.back() {
                if *val <= dp[i] {
                    deque.pop_back();
                } else {
                    break;
                }
            }

            // 5. Add the current score and index to the back of the deque.
            deque.push_back((dp[i], i));
        }

        // The maximum score to reach the last index is dp[n-1].
        dp[n - 1]
    }
}