impl Solution {
    pub fn max_sub_array(nums: Vec<i32>) -> i32 {
        let mut max_current = nums[0];
        let mut max_global = nums[0];

        for &num in nums.iter().skip(1) {
            max_current = num.max(max_current + num);
            max_global = max_global.max(max_current);
        }

        max_global
    }
}