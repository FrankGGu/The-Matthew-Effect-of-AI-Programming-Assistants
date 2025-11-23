impl Solution {
    pub fn min_operations(nums: Vec<i32>, target: i32) -> i32 {
        use std::collections::BinaryHeap;
        let mut heap = BinaryHeap::new();
        let mut sum: i64 = 0;
        for &num in &nums {
            heap.push(num as i64);
            sum += num as i64;
        }
        let target = target as i64;
        let mut operations = 0;
        while sum > target {
            if let Some(max) = heap.pop() {
                sum -= max;
                if max > 1 {
                    let half = max / 2;
                    heap.push(half);
                    heap.push(half);
                    sum += half * 2;
                }
                operations += 1;
            } else {
                return -1;
            }
        }
        operations
    }
}