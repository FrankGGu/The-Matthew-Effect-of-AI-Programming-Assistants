impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        use std::collections::BinaryHeap;
        use std::cmp::Reverse;

        let mut heap = BinaryHeap::new();
        for &num in &nums {
            heap.push(Reverse(num));
        }

        let mut operations = 0;
        while heap.peek().map(|&Reverse(x)| x).unwrap_or(0) < k && heap.len() > 1 {
            let Reverse(x) = heap.pop().unwrap();
            let Reverse(y) = heap.pop().unwrap();
            heap.push(Reverse(std::cmp::min(x * 2, y * 2)));
            operations += 1;
        }

        operations
    }
}