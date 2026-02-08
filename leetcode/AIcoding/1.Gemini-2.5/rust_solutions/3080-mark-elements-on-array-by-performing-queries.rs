use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn mark_elements(nums: Vec<i32>, queries: Vec<Vec<i32>>) -> Vec<i64> {
        let n = nums.len();
        let mut is_marked = vec![false; n];
        let mut total_sum: i64 = nums.iter().map(|&x| x as i64).sum();

        let mut min_heap: BinaryHeap<Reverse<(i32, usize)>> = BinaryHeap::new();
        for i in 0..n {
            min_heap.push(Reverse((nums[i], i)));
        }

        let mut results = Vec::with_capacity(queries.len());

        for query in queries {
            let idx = query[0] as usize;
            let k = query[1] as usize;

            if !is_marked[idx] {
                is_marked[idx] = true;
                total_sum -= nums[idx] as i64;
            }

            let mut marked_count = 0;
            while marked_count < k && !min_heap.is_empty() {
                let Reverse((val, original_idx)) = min_heap.pop().unwrap();

                if !is_marked[original_idx] {
                    is_marked[original_idx] = true;
                    total_sum -= val as i64;
                    marked_count += 1;
                }
            }
            results.push(total_sum);
        }

        results
    }
}