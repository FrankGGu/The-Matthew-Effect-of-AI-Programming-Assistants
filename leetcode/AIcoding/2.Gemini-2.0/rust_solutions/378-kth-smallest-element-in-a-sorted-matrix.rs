use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn kth_smallest(matrix: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = matrix.len();
        let mut heap: BinaryHeap<Reverse<i32>> = BinaryHeap::new();

        for i in 0..n {
            for j in 0..n {
                heap.push(Reverse(matrix[i][j]));
                if heap.len() as i32 > k {
                    heap.pop();
                }
            }
        }

        heap.peek().unwrap().0.0
    }
}