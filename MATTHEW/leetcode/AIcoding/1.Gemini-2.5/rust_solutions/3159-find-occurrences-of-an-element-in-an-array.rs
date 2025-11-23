impl Solution {
    pub fn find_occurrences(nums: Vec<i32>, x: i32, queries: Vec<i32>) -> Vec<i32> {
        let mut occurrences_indices: Vec<i32> = Vec::new();
        for (i, &num) in nums.iter().enumerate() {
            if num == x {
                occurrences_indices.push(i as i32);
            }
        }

        let mut results: Vec<i32> = Vec::with_capacity(queries.len());
        for &q_idx in queries.iter() {
            let q_idx_usize = q_idx as usize;
            if q_idx_usize < occurrences_indices.len() {
                results.push(occurrences_indices[q_idx_usize]);
            } else {
                results.push(-1);
            }
        }
        results
    }
}