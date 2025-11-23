impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn maximum_product(mut nums: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        for num in &nums {
            heap.push(*num);
        }

        for _ in 0..k {
            let val = heap.pop().unwrap();
            heap.push(val + 1);
        }

        let mut result = 1;
        while let Some(num) = heap.pop() {
            result = (result as i64 * num as i64) as i32;
        }

        result
    }
}
}