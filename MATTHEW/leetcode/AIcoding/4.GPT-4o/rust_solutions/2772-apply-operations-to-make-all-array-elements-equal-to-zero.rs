impl Solution {
    pub fn apply_operations(nums: &mut Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![0; n];
        let mut idx = 0;

        for i in 0..n {
            if nums[i] != 0 {
                if i < n - 1 && nums[i] == nums[i + 1] {
                    result[idx] = 2 * nums[i];
                    idx += 1;
                    i += 1;
                } else {
                    result[idx] = nums[i];
                    idx += 1;
                }
            }
        }

        result.truncate(idx);
        result
    }
}