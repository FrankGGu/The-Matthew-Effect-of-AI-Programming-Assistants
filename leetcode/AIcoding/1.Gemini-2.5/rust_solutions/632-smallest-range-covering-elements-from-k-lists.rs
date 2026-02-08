use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn smallest_range(nums: Vec<Vec<i32>>) -> Vec<i32> {
        let k = nums.len();
        if k == 0 {
            return vec![];
        }

        // min_heap stores (value, list_index, element_index_in_list)
        // Using Reverse to make BinaryHeap act as a min-heap
        let mut min_heap: BinaryHeap<Reverse<(i32, usize, usize)>> = BinaryHeap::new();
        let mut current_max = i32::MIN;

        // Initialize the heap with the first element from each of the k lists
        for i in 0..k {
            let val = nums[i][0];
            min_heap.push(Reverse((val, i, 0)));
            current_max = current_max.max(val);
        }

        // Initialize the best range found so far
        let mut range_start = min_heap.peek().unwrap().0.0;
        let mut range_end = current_max;

        // Continue processing until one of the lists is exhausted
        while let Some(Reverse((val, list_idx, elem_idx))) = min_heap.pop() {
            // Check if the current range [val, current_max] is smaller than the best found
            let current_range_diff = current_max - val;
            let best_range_diff = range_end - range_start;

            if current_range_diff < best_range_diff {
                range_start = val;
                range_end = current_max;
            } else if current_range_diff == best_range_diff && val < range_start {
                // Tie-breaking rule: if ranges are equal length, choose the one with smaller start
                range_start = val;
                range_end = current_max;
            }

            // Try to add the next element from the list from which 'val' was taken
            if elem_idx + 1 < nums[list_idx].len() {
                let next_val = nums[list_idx][elem_idx + 1];
                min_heap.push(Reverse((next_val, list_idx, elem_idx + 1)));
                current_max = current_max.max(next_val); // Update current_max if the new element is larger
            } else {
                // If a list is exhausted, we cannot form a range covering all lists anymore
                break;
            }
        }

        vec![range_start, range_end]
    }
}