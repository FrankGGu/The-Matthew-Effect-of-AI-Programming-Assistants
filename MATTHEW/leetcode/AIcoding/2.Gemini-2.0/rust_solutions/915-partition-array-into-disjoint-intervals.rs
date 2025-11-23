impl Solution {
    pub fn partition_disjoint(nums: Vec<i32>) -> i32 {
        let mut left_max = nums[0];
        let mut current_max = nums[0];
        let mut partition_index = 0;

        for i in 1..nums.len() {
            current_max = current_max.max(nums[i]);
            if nums[i] < left_max {
                left_max = current_max;
                partition_index = i;
            }
        }

        (partition_index + 1) as i32
    }
}