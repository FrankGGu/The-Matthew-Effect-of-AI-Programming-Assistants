impl Solution {
    pub fn is_harshad(n: i32) -> bool {
        let sum_of_digits: i32 = n.to_string().chars().map(|d| d.to_digit(10).unwrap() as i32).sum();
        n % sum_of_digits == 0
    }
}