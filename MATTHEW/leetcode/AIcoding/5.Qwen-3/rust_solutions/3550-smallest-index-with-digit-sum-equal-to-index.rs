struct Solution;

impl Solution {
    pub fn find_first_index(nums: Vec<i32>) -> i32 {
        for (i, &num) in nums.iter().enumerate() {
            let sum: i32 = num.to_string().chars().map(|c| c.to_digit(10).unwrap() as i32).sum();
            if sum == i as i32 {
                return i as i32;
            }
        }
        -1
    }
}