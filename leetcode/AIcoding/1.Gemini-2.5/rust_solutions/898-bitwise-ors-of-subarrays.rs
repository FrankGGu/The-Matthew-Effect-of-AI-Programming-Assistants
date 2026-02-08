use std::collections::HashSet;

impl Solution {
    pub fn subarray_bitwise_ors(arr: Vec<i32>) -> i32 {
        let mut total_unique_ors: HashSet<i32> = HashSet::new();
        let mut current_ors: HashSet<i32> = HashSet::new();

        for &num in arr.iter() {
            // Initialize a new set to store OR sums for subarrays ending at the current 'num'.
            let mut next_ors: HashSet<i32> = HashSet::new();

            // The current number itself forms a subarray of length 1.
            next_ors.insert(num);

            // For each OR sum found from subarrays ending at the previous element,
            // OR it with the current 'num' to form new OR sums ending at 'num'.
            for &prev_or_sum in current_ors.iter() {
                next_ors.insert(prev_or_sum | num);
            }

            // Add all newly generated OR sums to the global set of unique OR sums.
            for &new_or_sum in next_ors.iter() {
                total_unique_ors.insert(new_or_sum);
            }

            // Update 'current_ors' to be 'next_ors' for the next iteration.
            current_ors = next_ors;
        }

        total_unique_ors.len() as i32
    }
}