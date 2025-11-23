use std::collections::VecDeque;

impl Solution {
    pub fn shortest_subarray(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut prefix_sum: Vec<i64> = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i] as i64;
        }

        let mut ans = (n + 1) as i32;
        let mut deque: VecDeque<usize> = VecDeque::new();

        let k_long = k as i64;

        for i in 0..=n {
            // Condition 1: P[i] - P[j] >= K
            // While the deque is not empty and the current prefix sum minus the prefix sum at the front of the deque is at least K,
            // we have found a valid subarray. Update the minimum length and remove the front element
            // because it's no longer useful for finding shorter subarrays.
            while let Some(&j) = deque.front() {
                if prefix_sum[i] - prefix_sum[j] >= k_long {
                    ans = ans.min((i - j) as i32);
                    deque.pop_front();
                } else {
                    // Since prefix_sum values in the deque are strictly increasing,
                    // if P[i] - P[deque.front()] < K, then for any other j' in the deque (j' > deque.front()),
                    // P[j'] > P[deque.front()], so P[i] - P[j'] < P[i] - P[deque.front()] < K.
                    // Thus, no other element currently in the deque will satisfy the condition with P[i].
                    break;
                }
            }

            // Condition 2: Maintain monotonic increasing prefix sums in deque
            // While the deque is not empty and the current prefix sum is less than or equal to the prefix sum at the back of the deque,
            // remove the back element. This is because the current index `i` offers a smaller or equal prefix sum
            // at a later index, making it a better candidate for `j` for any future `P[x]` (where `x > i`).
            while let Some(&j) = deque.back() {
                if prefix_sum[i] <= prefix_sum[j] {
                    deque.pop_back();
                } else {
                    // P[i] > P[j], so it's fine to add P[i] after P[j] to maintain the increasing order.
                    break;
                }
            }

            // Add the current index to the back of the deque.
            deque.push_back(i);
        }

        if ans == (n + 1) as i32 {
            -1
        } else {
            ans
        }
    }
}