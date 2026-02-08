use std::collections::BinaryHeap;

impl Solution {
    pub fn is_possible(target: Vec<i32>) -> bool {
        let mut sum: i64 = 0;
        let mut heap = BinaryHeap::new();

        for &num in &target {
            sum += num as i64;
            heap.push(num as i64);
        }

        while let Some(mut max) = heap.pop() {
            if max == 1 {
                return true;
            }
            let remaining_sum = sum - max;
            if remaining_sum == 0 || max <= remaining_sum {
                return false;
            }
            let prev = max % remaining_sum;
            if prev == 0 {
                if remaining_sum == 1 {
                    prev = 1;
                } else {
                    return false;
                }
            }
            sum = remaining_sum + prev;
            heap.push(prev);
        }

        true
    }
}