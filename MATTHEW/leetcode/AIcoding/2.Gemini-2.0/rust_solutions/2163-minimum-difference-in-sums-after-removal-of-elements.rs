use std::collections::BinaryHeap;

impl Solution {
    pub fn minimum_difference(nums: Vec<i32>) -> i64 {
        let n = nums.len() / 3;
        let mut left = vec![0; nums.len()];
        let mut right = vec![0; nums.len()];

        let mut heap: BinaryHeap<i32> = nums[..n].iter().map(|&x| -x).collect();
        left[n - 1] = nums[..n].iter().map(|&x| x as i64).sum();

        for i in n..2 * n {
            let top = -heap.peek().unwrap();
            if nums[i] > top {
                heap.pop();
                heap.push(-nums[i]);
                left[i] = left[i - 1] + nums[i] as i64 - top as i64;
            } else {
                left[i] = left[i - 1];
            }
        }

        let mut heap: BinaryHeap<i32> = nums[2 * n..].iter().cloned().collect();
        right[2 * n] = nums[2 * n..].iter().map(|&x| x as i64).sum();

        for i in (n..2 * n).rev() {
            let top = *heap.peek().unwrap();
            if nums[i] < top {
                heap.pop();
                heap.push(nums[i]);
                right[i] = right[i + 1] + nums[i] as i64 - top as i64;
            } else {
                right[i] = right[i + 1];
            }
        }

        let mut ans = i64::MAX;
        for i in n - 1..2 * n {
            ans = ans.min(left[i] - right[i + 1]);
        }

        ans
    }
}