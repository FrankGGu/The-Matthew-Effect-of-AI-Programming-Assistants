impl Solution {
    pub fn minimum_element_after_replacement(nums: Vec<i32>) -> i32 {
        let mut min_val = i32::MAX;

        for &num in nums.iter() {
            let transformed_num = if num % 9 == 0 {
                9
            } else {
                num % 9
            };
            min_val = min_val.min(transformed_num);
        }

        min_val
    }
}