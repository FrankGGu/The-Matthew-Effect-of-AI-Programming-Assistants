use std::collections::BinaryHeap;

impl Solution {
    pub fn maximum_product(nums: Vec<i32>, k: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        for num in nums {
            heap.push(-num);
        }
        for _ in 0..k {
            if let Some(min) = heap.pop() {
                heap.push(min - 1);
            }
        }
        let modulo = 1_000_000_007;
        let mut product = 1i64;
        while let Some(num) = heap.pop() {
            product = (product * (-num as i64)) % modulo;
        }
        product as i32
    }
}