use std::collections::VecDeque;

impl Solution {
    pub fn max_sliding_window(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let k = k as usize;
        let n = nums.len();
        if n == 0 || k == 0 {
            return vec![];
        }

        let mut result = Vec::with_capacity(n - k + 1);
        let mut dq: VecDeque<usize> = VecDeque::new();

        for i in 0..n {
            // Remove elements from the front of the deque if they are outside the current window
            if let Some(&front_idx) = dq.front() {
                if front_idx <= i - k {
                    dq.pop_front();
                }
            }

            // Remove elements from the back of the deque that are smaller than the current element
            // because they can no longer be the maximum in any future window that includes the current element
            while let Some(&back_idx) = dq.back() {
                if nums[back_idx] <= nums[i] {
                    dq.pop_back();
                } else {
                    break;
                }
            }

            // Add current element's index to the back of the deque
            dq.push_back(i);

            // If the window is fully formed, the front of the deque contains the index of the maximum element
            if i >= k - 1 {
                result.push(nums[*dq.front().unwrap()]);
            }
        }

        result
    }
}