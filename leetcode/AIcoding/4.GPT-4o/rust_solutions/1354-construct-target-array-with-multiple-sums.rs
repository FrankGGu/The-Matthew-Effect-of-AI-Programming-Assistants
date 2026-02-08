use std::collections::BinaryHeap;

impl Solution {
    pub fn is_possible(target: Vec<i32>) -> bool {
        let mut total: i64 = target.iter().map(|&x| x as i64).sum();
        let mut max_heap = BinaryHeap::new();

        for &num in &target {
            max_heap.push(num as i64);
        }

        while let Some(max) = max_heap.pop() {
            total -= max;
            if max <= 1 || total <= 0 {
                return total == 0;
            }
            let new_val = max % total;
            if new_val == 0 {
                return false;
            }
            total += new_val;
            max_heap.push(new_val);
        }
        true
    }
}