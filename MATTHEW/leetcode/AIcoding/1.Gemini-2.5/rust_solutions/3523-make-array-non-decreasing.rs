use std::collections::BinaryHeap;

impl Solution {
    pub fn make_array_non_decreasing(nums: Vec<i32>) -> i64 {
        let mut cost: i64 = 0;
        let mut pq = BinaryHeap::new(); // BinaryHeap in Rust is a max-heap by default

        for num in nums {
            // If the current number is smaller than the largest element in our heap,
            // it means we have a decreasing sequence.
            // To make it non-decreasing, we must increase the largest element from the heap
            // to match the current number.
            // The cost incurred is the difference.
            if let Some(&top_val) = pq.peek() {
                if top_val > num {
                    cost += (top_val - num) as i64;
                    pq.pop();
                    pq.push(num); // Replace the larger element with the current smaller one
                }
            }
            // Always push the current number.
            // If it was smaller than `top_val` and `top_val` was popped and `num` pushed,
            // this `num` is for the current position.
            // If `top_val <= num`, then `num` is simply added.
            pq.push(num);
        }

        cost
    }
}