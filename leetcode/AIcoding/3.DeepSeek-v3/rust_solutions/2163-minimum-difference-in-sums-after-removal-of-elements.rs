use std::collections::BinaryHeap;

impl Solution {
    pub fn minimum_difference(nums: Vec<i32>) -> i64 {
        let n = nums.len() / 3;
        let mut prefix = vec![0; n + 1];
        let mut max_heap = BinaryHeap::new();
        let mut sum = 0i64;

        for i in 0..n {
            max_heap.push(nums[i]);
            sum += nums[i] as i64;
        }
        prefix[0] = sum;

        for i in n..2 * n {
            max_heap.push(nums[i]);
            sum += nums[i] as i64;
            let popped = max_heap.pop().unwrap();
            sum -= popped as i64;
            prefix[i - n + 1] = sum;
        }

        let mut suffix = vec![0; n + 1];
        let mut min_heap = BinaryHeap::new();
        sum = 0;

        for i in (2 * n..3 * n).rev() {
            min_heap.push(-nums[i]);
            sum += nums[i] as i64;
        }
        suffix[n] = sum;

        for i in (n..2 * n).rev() {
            min_heap.push(-nums[i]);
            sum += nums[i] as i64;
            let popped = -min_heap.pop().unwrap();
            sum -= popped as i64;
            suffix[i - n] = sum;
        }

        let mut res = i64::MAX;
        for i in 0..=n {
            res = res.min(prefix[i] - suffix[i]);
        }

        res
    }
}