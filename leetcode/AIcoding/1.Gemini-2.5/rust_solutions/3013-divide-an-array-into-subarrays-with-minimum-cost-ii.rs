use std::collections::VecDeque;

impl Solution {
    pub fn minimum_cost(nums: Vec<i32>, k: i32, dist: i32) -> i64 {
        let n = nums.len();
        let k = k as usize;
        let dist = dist as isize;

        // dp[j] stores the minimum total cost to form `i+1` subarrays,
        // where the `(i+1)`-th subarray starts at index `j`.
        // The costs are the sum of the first elements of these `i+1` subarrays.
        // Initialize dp for the first subarray (i=0).
        // dp[0] means 1 subarray, starting at index 0. Cost is nums[0].
        let mut dp: Vec<i64> = vec![i64::MAX; n];
        dp[0] = nums[0] as i64;

        // Iterate k-1 times to find the minimum cost for 2nd to k-th subarrays.
        // `i` represents the number of *additional* subarrays chosen so far.
        // So `i` goes from 1 to `k-1`.
        for i in 1..k {
            let mut next_dp: Vec<i64> = vec![i64::MAX; n];
            // Deque stores (cost, index) pairs for dp[p] values,
            // maintaining a monotonic increasing order of costs.
            let mut deque: VecDeque<(i64, usize)> = VecDeque::new();

            // Iterate `j` from `i` to `n-1`.
            // `j` is the starting index for the `(i+1)`-th subarray.
            // The `(i+1)`-th subarray must start at or after index `i`.
            // The previous subarray (i-th) must have started at `p`.
            // The constraint on `p` is `[max(i-1, j-1-dist), j-1]`.

            // For each `j` (current starting index for `next_dp`):
            // 1. Add `dp[j-1]` to the deque (if `j-1` is a valid previous start index and its cost is not MAX).
            //    `j-1` is a valid previous start index if `j-1 >= i-1`.
            //    Since `j` starts from `i`, `j-1 >= i-1` is always true.
            //    So we only need to check `dp[j-1] != i64::MAX`.
            // 2. Remove outdated elements from the front of the deque.
            // 3. Query the minimum from the deque to calculate `next_dp[j]`.
            for j in i..n {
                // Step 1: Add `dp[j-1]` to the deque.
                if dp[j - 1] != i64::MAX {
                    while let Some(&(val, _)) = deque.back() {
                        if val >= dp[j - 1] {
                            deque.pop_back();
                        } else {
                            break;
                        }
                    }
                    deque.push_back((dp[j - 1], j - 1));
                }

                // Step 2: Remove elements from the front of the deque whose index `p` is too small.
                // `p` must be `>= j-1-dist`.
                while let Some(&(val, idx)) = deque.front() {
                    if idx < (j as isize - 1 - dist) as usize {
                        deque.pop_front();
                    } else {
                        break;
                    }
                }

                // Step 3: Calculate `next_dp[j]` using the minimum from the deque.
                if let Some(&(min_prev_cost, _)) = deque.front() {
                    next_dp[j] = nums[j] as i64 + min_prev_cost;
                }
            }
            dp = next_dp;
        }

        // The final answer is the minimum cost among all possible ending positions for the k-th subarray.
        // The k-th subarray must start at an index `j` such that `j >= k-1`.
        let mut min_total_cost = i64::MAX;
        for j in (k - 1)..n {
            min_total_cost = min_total_cost.min(dp[j]);
        }

        min_total_cost
    }
}