use std::collections::BinaryHeap;

impl Solution {
    pub fn is_possible(target: Vec<i32>) -> bool {
        let mut sum: i64 = target.iter().map(|&x| x as i64).sum();
        let mut heap = BinaryHeap::new();
        for &x in &target {
            heap.push(x as i64);
        }

        while let Some(val) = heap.pop() {
            if val == 1 {
                return true;
            }

            let rest = sum - val;

            if rest == 1 {
                return true;
            }

            if rest >= val || rest == 0 {
                return false;
            }

            let prev = val % rest;

            if prev == 0 {
                return false;
            }

            heap.push(prev);
            sum = rest + prev;
        }

        false
    }
}