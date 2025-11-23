impl Solution {
    pub fn apply_operations(nums: &mut Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![0; n];
        let mut index = 0;

        for i in 0..n {
            if i < n - 1 && nums[i] == nums[i + 1] {
                result[index] = nums[i] * 2;
                index += 1;
                i += 1; // Skip the next element since it's combined
            } else {
                result[index] = nums[i];
                index += 1;
            }
        }

        result.truncate(index);
        result.append(&mut vec![0; n - index]);
        result
    }
}