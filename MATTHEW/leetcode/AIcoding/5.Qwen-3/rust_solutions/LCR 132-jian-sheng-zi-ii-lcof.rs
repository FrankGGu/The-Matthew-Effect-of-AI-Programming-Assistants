impl Solution {

use std::collections::BinaryHeap;

struct Solution {}

impl Solution {
    pub fn remove_sticks(mut sticks: Vec<i32>) -> i32 {
        let mut heap = BinaryHeap::new();
        for s in sticks {
            heap.push(s);
        }

        let mut result = 0;
        while heap.len() > 1 {
            let a = heap.pop().unwrap();
            let b = heap.pop().unwrap();
            let sum = a + b;
            result += sum;
            heap.push(sum);
        }

        result
    }
}
}