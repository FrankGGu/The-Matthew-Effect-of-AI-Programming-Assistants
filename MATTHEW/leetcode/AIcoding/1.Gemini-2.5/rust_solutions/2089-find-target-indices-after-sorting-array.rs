impl Solution {
    pub fn target_indices(nums: Vec<i32>, target: i32) -> Vec<i32> {
        let mut sorted_nums = nums;
        sorted_nums.sort_unstable();

        let mut result = Vec::new();
        for (i, &num) in sorted_nums.iter().enumerate() {
            if num == target {
                result.push(i as i32);
            }
        }
        result
    }
}