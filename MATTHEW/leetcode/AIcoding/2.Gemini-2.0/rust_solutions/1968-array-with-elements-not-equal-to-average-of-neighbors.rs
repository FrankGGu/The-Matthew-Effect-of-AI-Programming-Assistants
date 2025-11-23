impl Solution {
    pub fn rearrange_array(nums: Vec<i32>) -> Vec<i32> {
        let mut nums = nums;
        nums.sort();
        let n = nums.len();
        let mut result = vec![0; n];
        let mut left = 0;
        let mut right = n - 1;
        for i in 0..n {
            if i % 2 == 0 {
                result[i] = nums[left];
                left += 1;
            } else {
                result[i] = nums[right];
                right -= 1;
            }
        }
        result
    }
}