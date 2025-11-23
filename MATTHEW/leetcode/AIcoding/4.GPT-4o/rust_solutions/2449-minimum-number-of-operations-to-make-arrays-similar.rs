impl Solution {
    pub fn min_operations(nums: Vec<i32>, target: Vec<i32>) -> i32 {
        let mut nums = nums;
        let mut target = target;
        nums.sort();
        target.sort();
        let mut ops = 0;

        for i in 0..nums.len() {
            ops += (nums[i] - target[i]).abs();
        }

        ops / 2
    }
}