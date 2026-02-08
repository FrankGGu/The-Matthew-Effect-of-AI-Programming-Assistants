use std::collections::BinaryHeap;

impl Solution {
    pub fn max_result(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        if n == 0 {
            return 0;
        }
        if n == 1 {
            return nums[0];
        }

        let mut heap: BinaryHeap<(i64, usize)> = BinaryHeap::new();

        let mut current_max_score: i64 = nums[0] as i64;
        heap.push((current_max_score, 0));

        for i in 1..n {
            let min_valid_index = (i as i32 - k).max(0) as usize;

            while let Some(&(score, index)) = heap.peek() {
                if index < min_valid_index {
                    heap.pop();
                } else {
                    break;
                }
            }

            let (max_prev_score, _) = heap.peek().unwrap();

            current_max_score = nums[i] as i64 + max_prev_score;

            heap.push((current_max_score, i));
        }

        current_max_score as i32
    }
}