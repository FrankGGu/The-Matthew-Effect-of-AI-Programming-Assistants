impl Solution {
    pub fn separate_digits(nums: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        for num in nums {
            let digits = num.to_string().chars().map(|d| d.to_digit(10).unwrap() as i32);
            result.extend(digits);
        }
        result
    }
}