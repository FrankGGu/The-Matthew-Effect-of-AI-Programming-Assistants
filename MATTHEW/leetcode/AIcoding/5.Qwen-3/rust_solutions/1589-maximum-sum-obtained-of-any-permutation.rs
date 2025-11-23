impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

struct Solution;

impl Solution {
    pub fn max_sum(mut nums: Vec<i32>) -> i32 {
        let mut heap = BinaryHeap::new();
        for num in &nums {
            heap.push(Reverse(*num));
        }

        let mut result = 0;
        let mut index = 1;

        while let Some(Reverse(num)) = heap.pop() {
            result += num * index;
            index += 1;
        }

        result
    }
}
}