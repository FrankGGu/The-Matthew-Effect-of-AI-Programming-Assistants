impl Solution {
    pub fn kth_smallest_trimmed_number(nums: Vec<String>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let mut results: Vec<i32> = Vec::with_capacity(queries.len());
        let num_len = nums[0].len();

        for query in queries {
            let k = query[0] as usize;
            let trim = query[1] as usize;

            let mut trimmed_nums_with_indices: Vec<(String, usize)> = Vec::with_capacity(nums.len());

            for (original_idx, num_str) in nums.iter().enumerate() {
                let start_idx = num_len - trim;
                let trimmed_s = &num_str[start_idx..];
                trimmed_nums_with_indices.push((trimmed_s.to_string(), original_idx));
            }

            trimmed_nums_with_indices.sort_unstable();

            let (_, original_index) = trimmed_nums_with_indices[k - 1];
            results.push(original_index as i32);
        }

        results
    }
}