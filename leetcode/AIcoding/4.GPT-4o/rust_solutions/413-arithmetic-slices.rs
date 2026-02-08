impl Solution {
    pub fn number_of_arithmetic_slices(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        let mut current = 0;

        for i in 2..nums.len() {
            if nums[i] - nums[i - 1] == nums[i - 1] - nums[i - 2] {
                current += 1;
                count += current;
            } else {
                current = 0;
            }
        }

        count
    }
}