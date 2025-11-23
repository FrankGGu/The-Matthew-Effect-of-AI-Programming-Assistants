impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn maximum_value_sum(queen: Vec<Vec<i32>>) -> i32 {
        let n = queen.len();
        let mut row_sums = vec![0; n];
        let mut col_sums = vec![0; n];

        for i in 0..n {
            for j in 0..n {
                row_sums[i] += queen[i][j];
                col_sums[j] += queen[i][j];
            }
        }

        let mut max_heap = BinaryHeap::new();
        for i in 0..n {
            max_heap.push(Reverse(row_sums[i]));
            max_heap.push(Reverse(col_sums[i]));
        }

        let mut sum = 0;
        let mut count = 0;

        while let Some(Reverse(val)) = max_heap.pop() {
            if count < 3 {
                sum += val;
                count += 1;
            } else {
                break;
            }
        }

        sum
    }
}
}