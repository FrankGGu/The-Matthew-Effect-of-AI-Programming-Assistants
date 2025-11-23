use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn find_score(nums: Vec<i32>) -> i64 {
        let mut heap = BinaryHeap::new();
        let n = nums.len();
        let mut marked = vec![false; n];

        for (i, &num) in nums.iter().enumerate() {
            heap.push((Reverse(num), i));
        }

        let mut score = 0i64;

        while let Some((Reverse(num), i)) = heap.pop() {
            if marked[i] {
                continue;
            }
            score += num as i64;
            marked[i] = true;
            if i > 0 {
                marked[i - 1] = true;
            }
            if i + 1 < n {
                marked[i + 1] = true;
            }
        }

        score
    }
}