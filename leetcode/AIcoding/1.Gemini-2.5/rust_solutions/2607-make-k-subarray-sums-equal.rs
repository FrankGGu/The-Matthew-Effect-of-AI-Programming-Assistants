impl Solution {
    pub fn make_k_subarray_sums_equal(nums: Vec<i32>, k: i32) -> i64 {
        let n = nums.len();
        let k_usize = k as usize;
        let mut total_operations: i64 = 0;

        for start_idx in 0..k_usize {
            let mut group_elements = Vec::new();
            let mut current_idx = start_idx;
            while current_idx < n {
                group_elements.push(nums[current_idx]);
                current_idx += k_usize;
            }

            group_elements.sort_unstable();

            let median = group_elements[group_elements.len() / 2];

            for &num in &group_elements {
                total_operations += (num - median).abs() as i64;
            }
        }

        total_operations
    }
}