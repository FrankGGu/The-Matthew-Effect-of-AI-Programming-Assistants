impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let mut ops = 0;
        let mut current_min = 0;
        let mut temp_nums = nums.clone();

        for i in 0..temp_nums.len() {
            temp_nums[i] -= current_min;

            if temp_nums[i] > 0 {
                ops += 1;
                current_min += temp_nums[i];
            }
        }

        ops
    }
}