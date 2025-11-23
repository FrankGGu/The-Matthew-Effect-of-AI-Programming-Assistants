impl Solution {
    pub fn find_the_array_concatenation_value(nums: Vec<i32>) -> i64 {
        let mut total_concatenation_value: i64 = 0;
        let mut left = 0;
        let mut right = nums.len() as isize - 1;

        while left <= right {
            if left == right {
                total_concatenation_value += nums[left as usize] as i64;
            } else {
                let s1 = nums[left as usize].to_string();
                let s2 = nums[right as usize].to_string();
                let concatenated_str = format!("{}{}", s1, s2);
                total_concatenation_value += concatenated_str.parse::<i64>().unwrap();
            }
            left += 1;
            right -= 1;
        }

        total_concatenation_value
    }
}