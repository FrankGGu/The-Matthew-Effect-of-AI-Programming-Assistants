impl Solution {
    pub fn minimum_cost(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        let first = nums[0];
        nums.remove(0);
        nums.sort();
        first + nums[0] + nums[1]
    }
}