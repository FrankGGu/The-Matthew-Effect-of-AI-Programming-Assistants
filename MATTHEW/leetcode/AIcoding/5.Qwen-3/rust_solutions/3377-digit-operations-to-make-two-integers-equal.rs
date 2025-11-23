struct Solution;

impl Solution {
    pub fn equalize_numbers(mut a: i32, mut b: i32) -> i32 {
        let mut operations = 0;
        while a != b {
            if a > b {
                a /= 10;
            } else {
                b /= 10;
            }
            operations += 1;
        }
        operations
    }
}