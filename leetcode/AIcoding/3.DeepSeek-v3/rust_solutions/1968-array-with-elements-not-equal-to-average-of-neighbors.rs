impl Solution {
    pub fn rearrange_array(nums: Vec<i32>) -> Vec<i32> {
        let mut nums = nums;
        nums.sort_unstable();
        let mut res = Vec::with_capacity(nums.len());
        let (mut left, mut right) = (0, nums.len() - 1);
        while left <= right {
            if left == right {
                res.push(nums[left]);
            } else {
                res.push(nums[left]);
                res.push(nums[right]);
            }
            left += 1;
            right -= 1;
        }
        res
    }
}