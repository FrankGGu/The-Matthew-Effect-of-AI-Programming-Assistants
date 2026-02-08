impl Solution {
    pub fn separate_digits(nums: Vec<i32>) -> Vec<i32> {
        let mut result = Vec::new();
        for num in nums {
            let digits: Vec<i32> = num.to_string().chars().map(|c| c.to_digit(10).unwrap() as i32).collect();
            result.extend(digits);
        }
        result
    }
}