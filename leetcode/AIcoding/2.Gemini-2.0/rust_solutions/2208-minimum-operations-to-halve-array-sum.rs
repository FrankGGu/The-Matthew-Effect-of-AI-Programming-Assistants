use std::collections::BinaryHeap;

impl Solution {
    pub fn halve_array(nums: Vec<i32>) -> i32 {
        let mut heap = BinaryHeap::new();
        let mut sum: f64 = 0.0;
        for &num in &nums {
            let num_f64 = num as f64;
            sum += num_f64;
            heap.push(OrderedFloat(num_f64));
        }

        let mut operations = 0;
        let mut halved_sum: f64 = 0.0;

        while halved_sum < sum / 2.0 {
            let OrderedFloat(largest) = heap.pop().unwrap();
            halved_sum += largest / 2.0;
            heap.push(OrderedFloat(largest / 2.0));
            operations += 1;
        }

        operations
    }
}

use std::cmp::Ordering;

#[derive(PartialEq, PartialOrd, Debug, Copy, Clone)]
struct OrderedFloat(f64);

impl Eq for OrderedFloat {}

impl Ord for OrderedFloat {
    fn cmp(&self, other: &Self) -> Ordering {
        self.0.partial_cmp(&other.0).unwrap().reverse()
    }
}