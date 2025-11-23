impl Solution {
    pub fn separate_digits(nums: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        for num in nums {
            let num_str = num.to_string();
            for digit in num_str.chars() {
                result.push(digit.to_digit(10).unwrap() as i32);
            }
        }
        result
    }
}