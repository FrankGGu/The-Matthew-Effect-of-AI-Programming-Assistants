use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(PartialEq, PartialOrd, Clone, Copy)]
struct OrderedFloat(f64);

impl Eq for OrderedFloat {}

impl Ord for OrderedFloat {
    fn cmp(&self, other: &Self) -> Ordering {
        self.0.total_cmp(&other.0)
    }
}

impl Solution {
    pub fn halve_array(nums: Vec<i32>) -> i32 {
        let mut heap = BinaryHeap::new();
        let mut initial_sum: f64 = 0.0;

        for num in nums {
            let float_num = num as f64;
            initial_sum += float_num;
            heap.push(OrderedFloat(float_num));
        }

        let target_reduction = initial_sum / 2.0;
        let mut current_reduction: f64 = 0.0;
        let mut operations: i32 = 0;

        while current_reduction < target_reduction {
            operations += 1;

            // Pop the largest element from the max-heap
            let OrderedFloat(max_val) = heap.pop().unwrap();

            // Calculate the reduction from this element
            let reduction_amount = max_val / 2.0;
            current_reduction += reduction_amount;

            // Push the reduced element back into the heap
            heap.push(OrderedFloat(max_val - reduction_amount));
        }

        operations
    }
}