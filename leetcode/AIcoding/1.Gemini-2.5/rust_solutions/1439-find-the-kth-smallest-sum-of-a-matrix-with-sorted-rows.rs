use std::collections::{BinaryHeap, HashSet};
use std::cmp::Reverse;

impl Solution {
    pub fn kth_smallest_sum(mat: Vec<Vec<i32>>, k: i32) -> i32 {
        let k_usize = k as usize;

        // Initialize current_sums with the elements of the first row.
        // These are the initial possible sums when considering only one row.
        let mut current_sums = mat[0].clone();

        // Iterate through the rest of the rows, merging them one by one.
        for r_idx in 1..mat.len() {
            let next_row = &mat[r_idx];
            // Merge the current list of sums with the elements of the next row.
            // Keep only the k_usize smallest sums from the merged list.
            current_sums = Solution::merge_two_sorted_lists(current_sums, next_row.to_vec(), k_usize);
        }

        // After processing all rows, current_sums will contain the k_usize smallest
        // possible sums. The k-th smallest sum is at index k_usize - 1.
        current_sums[k_usize - 1]
    }

    // Helper function to merge two sorted lists (list1 and list2) and return
    // a new sorted list containing the k_usize smallest sums of elements
    // taken one from list1 and one from list2.
    // This uses a min-heap to efficiently find the smallest sums.
    fn merge_two_sorted_lists(list1: Vec<i32>, list2: Vec<i32>, k_usize: usize) -> Vec<i32> {
        let mut result = Vec::new();

        // If either list is empty, no sums can be formed.
        if list1.is_empty() || list2.is_empty() {
            return result;
        }

        // Min-heap to store tuples of (sum, index_in_list1, index_in_list2).
        // `Reverse` is used to make BinaryHeap act as a min-heap.
        let mut heap = BinaryHeap::new();
        // HashSet to keep track of visited (index_in_list1, index_in_list2) pairs
        // to avoid duplicate calculations and infinite loops.
        let mut visited = HashSet::new();

        // Start with the smallest possible sum: list1[0] + list2[0].
        heap.push(Reverse((list1[0] + list2[0], 0, 0)));
        visited.insert((0, 0));

        // Continue extracting sums until we have k_usize sums or the heap is empty.
        while result.len() < k_usize && !heap.is_empty() {
            let Reverse((sum, i, j)) = heap.pop().unwrap();
            result.push(sum);

            // Explore the next possible sum by incrementing the index in list2.
            // (i, j+1) represents list1[i] + list2[j+1].
            if j + 1 < list2.len() && !visited.contains(&(i, j + 1)) {
                heap.push(Reverse((list1[i] + list2[j + 1], i, j + 1)));
                visited.insert((i, j + 1));
            }

            // Explore the next possible sum by incrementing the index in list1.
            // (i+1, j) represents list1[i+1] + list2[j].
            if i + 1 < list1.len() && !visited.contains(&(i + 1, j)) {
                heap.push(Reverse((list1[i + 1] + list2[j], i + 1, j)));
                visited.insert((i + 1, j));
            }
        }

        result
    }
}