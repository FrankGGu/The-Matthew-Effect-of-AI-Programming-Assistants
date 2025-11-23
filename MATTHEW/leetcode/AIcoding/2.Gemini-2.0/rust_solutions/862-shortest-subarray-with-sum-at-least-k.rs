use std::collections::VecDeque;

impl Solution {
    pub fn shortest_subarray(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let mut prefix_sum: Vec<i64> = vec![0; n + 1];
        for i in 0..n {
            prefix_sum[i + 1] = prefix_sum[i] + nums[i] as i64;
        }

        let mut deque: VecDeque<usize> = VecDeque::new();
        let mut min_len = i32::MAX;

        for i in 0..=n {
            while !deque.is_empty() && prefix_sum[i] - prefix_sum[*deque.front().unwrap()] >= k as i64 {
                min_len = min_len.min((i - deque.pop_front().unwrap()) as i32);
            }

            while !deque.is_empty() && prefix_sum[*deque.back().unwrap()] >= prefix_sum[i] {
                deque.pop_back();
            }

            deque.push_back(i);
        }

        if min_len == i32::MAX {
            -1
        } else {
            min_len
        }
    }
}