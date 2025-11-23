impl Solution {
    pub fn make_numbers_equal(mut num1: i32, mut num2: i32) -> i32 {
        let mut operations = 0;
        while num1 != 0 || num2 != 0 {
            let digit1 = num1 % 10;
            let digit2 = num2 % 10;
            operations += (digit1 - digit2).abs();
            num1 /= 10;
            num2 /= 10;
        }
        operations
    }
}