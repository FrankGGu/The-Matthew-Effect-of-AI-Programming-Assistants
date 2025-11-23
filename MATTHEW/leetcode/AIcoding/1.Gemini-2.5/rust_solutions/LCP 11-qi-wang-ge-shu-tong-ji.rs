struct Solution;

impl Solution {
    pub fn count_numbers(nums: Vec<i32>) -> i32 {
        let mut count = 0;
        for num in nums {
            if num >= 10 && num <= 20 {
                count += 1;
            }
        }
        count
    }
}