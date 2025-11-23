struct Solution;

impl Solution {
    pub fn minimum_element_after_replacement(mut nums: Vec<i32>) -> i32 {
        for i in 0..nums.len() {
            let mut sum = 0;
            let mut num = nums[i];
            while num > 0 {
                sum += num % 10;
                num /= 10;
            }
            nums[i] = sum;
        }
        *nums.iter().min().unwrap()
    }
}