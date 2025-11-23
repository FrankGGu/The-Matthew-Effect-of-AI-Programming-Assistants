impl Solution {
    pub fn sum_of_the_digits_of_harshad_number(x: i32) -> i32 {
        let sum: i32 = x.to_string().chars().map(|c| c.to_digit(10).unwrap() as i32).sum();
        if x % sum == 0 {
            sum
        } else {
            -1
        }
    }
}