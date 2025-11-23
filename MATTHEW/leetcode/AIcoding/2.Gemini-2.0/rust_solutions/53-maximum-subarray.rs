impl Solution {
    pub fn max_sub_array(nums: Vec<i32>) -> i32 {
        let mut max_so_far = nums[0];
        let mut current_max = nums[0];

        for i in 1..nums.len() {
            current_max = nums[i].max(current_max + nums[i]);
            max_so_far = max_so_far.max(current_max);
        }

        max_so_far
    }
}