use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn min_cost_to_combine_files(files: Vec<i32>) -> i32 {
        if files.len() <= 1 {
            return 0;
        }

        let mut heap = BinaryHeap::new();
        for &file_size in &files {
            heap.push(Reverse(file_size));
        }

        let mut total_cost = 0;

        while heap.len() > 1 {
            let file1 = heap.pop().unwrap().0;
            let file2 = heap.pop().unwrap().0;

            let combined_size = file1 + file2;
            total_cost += combined_size;

            heap.push(Reverse(combined_size));
        }

        total_cost
    }
}