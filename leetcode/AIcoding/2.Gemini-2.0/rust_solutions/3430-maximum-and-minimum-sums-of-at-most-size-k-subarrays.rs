use std::collections::VecDeque;

impl Solution {
    pub fn max_min_sums(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let k = k as usize;
        let n = nums.len();
        let mut max_queue: VecDeque<usize> = VecDeque::new();
        let mut min_queue: VecDeque<usize> = VecDeque::new();
        let mut max_sums: Vec<i32> = Vec::new();
        let mut min_sums: Vec<i32> = Vec::new();

        for i in 0..n {
            while !max_queue.is_empty() && nums[*max_queue.back().unwrap()] <= nums[i] {
                max_queue.pop_back();
            }
            max_queue.push_back(i);

            while !min_queue.is_empty() && nums[*min_queue.back().unwrap()] >= nums[i] {
                min_queue.pop_back();
            }
            min_queue.push_back(i);

            if i >= k - 1 {
                max_sums.push(nums[*max_queue.front().unwrap()]);
                min_sums.push(nums[*min_queue.front().unwrap()]);

                if *max_queue.front().unwrap() <= i - k + 1 {
                    max_queue.pop_front();
                }
                if *min_queue.front().unwrap() <= i - k + 1 {
                    min_queue.pop_front();
                }
            }
        }

        vec![max_sums.into_iter().sum(), min_sums.into_iter().sum()]
    }
}