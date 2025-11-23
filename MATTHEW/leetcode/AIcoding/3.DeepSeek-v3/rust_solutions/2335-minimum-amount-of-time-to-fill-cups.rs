use std::collections::BinaryHeap;

impl Solution {
    pub fn fill_cups(amount: Vec<i32>) -> i32 {
        let mut heap = BinaryHeap::new();
        for &num in &amount {
            if num > 0 {
                heap.push(num);
            }
        }
        let mut time = 0;
        while !heap.is_empty() {
            let first = heap.pop().unwrap();
            if heap.is_empty() {
                return time + first;
            }
            let second = heap.pop().unwrap();
            time += 1;
            if first - 1 > 0 {
                heap.push(first - 1);
            }
            if second - 1 > 0 {
                heap.push(second - 1);
            }
        }
        time
    }
}