impl Solution {
    pub fn minimum_sum(num: i32) -> i32 {
        let mut digits: Vec<i32> = num.to_string().chars().map(|d| d.to_digit(10).unwrap() as i32).collect();
        digits.sort();
        (digits[0] * 10 + digits[2]) + (digits[1] * 10 + digits[3])
    }
}