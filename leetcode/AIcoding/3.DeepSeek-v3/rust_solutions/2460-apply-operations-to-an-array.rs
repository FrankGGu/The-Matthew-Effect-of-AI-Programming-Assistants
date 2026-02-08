impl Solution {
    pub fn apply_operations(nums: Vec<i32>) -> Vec<i32> {
        let mut nums = nums;
        let n = nums.len();
        for i in 0..n - 1 {
            if nums[i] == nums[i + 1] {
                nums[i] *= 2;
                nums[i + 1] = 0;
            }
        }
        let mut result = vec![0; n];
        let mut index = 0;
        for num in nums {
            if num != 0 {
                result[index] = num;
                index += 1;
            }
        }
        result
    }
}