impl Solution {
    pub fn max_subsequence(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let mut nums_with_indices: Vec<(i32, usize)> = nums.iter().enumerate().map(|(i, &num)| (num, i)).collect();
        nums_with_indices.sort_unstable_by(|a, b| b.0.cmp(&a.0));
        let indices = nums_with_indices.iter().take(k as usize).map(|&(_, index)| index).collect::<Vec<_>>();
        let mut result = vec![0; k as usize];
        for (i, &index) in indices.iter().enumerate() {
            result[i] = nums[index];
        }
        result.sort_unstable();
        result
    }
}