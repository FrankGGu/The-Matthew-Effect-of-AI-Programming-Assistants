impl Solution {
    pub fn minimum_element_after_replacement(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        for i in 0..nums.len() {
            while nums[i] >= 10 {
                nums[i] = nums[i].to_string().chars().map(|c| c.to_digit(10).unwrap() as i32).sum();
            }
        }
        *nums.iter().min().unwrap()
    }
}