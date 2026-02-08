impl Solution {
    pub fn max_subsequence(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let k = k as usize;
        let mut indices: Vec<usize> = (0..nums.len()).collect();
        indices.sort_by_key(|&i| nums[i]);

        let mut selected_indices: Vec<usize> = indices.iter().skip(nums.len() - k).cloned().collect();
        selected_indices.sort();

        let mut result: Vec<i32> = Vec::new();
        for &i in &selected_indices {
            result.push(nums[i]);
        }

        result
    }
}