impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn split_num(mut num: i32) -> i32 {
        let mut heap = BinaryHeap::new();
        while num > 0 {
            heap.push(num % 10);
            num /= 10;
        }

        let mut a = 0;
        let mut b = 0;

        while let Some(digit) = heap.pop() {
            a = a * 10 + digit;
            if let Some(digit) = heap.pop() {
                b = b * 10 + digit;
            }
        }

        a + b
    }
}
}