use std::collections::BinaryHeap;

impl Solution {
    pub fn is_possible(target: Vec<i32>) -> bool {
        if target.len() == 1 {
            return target[0] == 1;
        }

        let mut heap = BinaryHeap::new();
        let mut current_sum: i64 = 0;

        for &num in &target {
            heap.push(num as i64);
            current_sum += num as i64;
        }

        while let Some(max_val) = heap.pop() {
            if max_val == 1 {
                return true;
            }

            let other_sum = current_sum - max_val;

            if other_sum == 0 {
                return false;
            }

            let prev_val = (max_val - 1) % other_sum + 1;

            if prev_val >= max_val {
                return false;
            }

            current_sum = current_sum - max_val + prev_val;
            heap.push(prev_val);
        }

        false
    }
}