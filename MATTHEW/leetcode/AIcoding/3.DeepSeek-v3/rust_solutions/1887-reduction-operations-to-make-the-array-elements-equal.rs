impl Solution {
    pub fn reduction_operations(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort_unstable();
        let mut res = 0;
        let mut step = 0;
        for i in 1..nums.len() {
            if nums[i] != nums[i - 1] {
                step += 1;
            }
            res += step;
        }
        res
    }
}