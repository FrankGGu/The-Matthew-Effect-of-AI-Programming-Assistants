impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn take_wood(mut nums: Vec<i32>, mut k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        for num in nums {
            heap.push(num);
        }

        while k > 0 {
            let max = heap.pop().unwrap();
            let new_val = max / 2;
            heap.push(new_val);
            k -= 1;
        }

        let mut result = 0;
        while let Some(val) = heap.pop() {
            result += val;
        }

        result
    }
}
}