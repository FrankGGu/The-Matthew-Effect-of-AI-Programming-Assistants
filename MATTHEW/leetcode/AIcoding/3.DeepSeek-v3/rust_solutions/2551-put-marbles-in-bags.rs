use std::collections::BinaryHeap;

impl Solution {
    pub fn put_marbles(weights: Vec<i32>, k: i32) -> i64 {
        let k = k as usize;
        let n = weights.len();
        if k == 1 || k == n {
            return 0;
        }

        let mut min_heap = BinaryHeap::new();
        let mut max_heap = BinaryHeap::new();

        for i in 0..n - 1 {
            let sum = weights[i] + weights[i + 1];
            min_heap.push(sum);
            if min_heap.len() > k - 1 {
                min_heap.pop();
            }
            max_heap.push(-sum);
            if max_heap.len() > k - 1 {
                max_heap.pop();
            }
        }

        let min_sum: i64 = min_heap.into_iter().map(|x| x as i64).sum();
        let max_sum: i64 = max_heap.into_iter().map(|x| -x as i64).sum();

        max_sum - min_sum
    }
}