impl Solution {
    pub fn max_subsequence(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let mut indexed_nums: Vec<(i32, usize)> = nums
            .into_iter()
            .enumerate()
            .map(|(i, val)| (val, i))
            .collect();

        indexed_nums.sort_unstable_by(|a, b| b.0.cmp(&a.0));

        let mut top_k_elements: Vec<(i32, usize)> = indexed_nums.into_iter().take(k as usize).collect();

        top_k_elements.sort_unstable_by(|a, b| a.1.cmp(&b.1));

        top_k_elements.into_iter().map(|(val, _)| val).collect()
    }
}