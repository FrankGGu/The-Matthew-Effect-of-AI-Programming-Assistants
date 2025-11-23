impl Solution {
    pub fn count_numbers_with_unique_digits(n: i32) -> i32 {
        if n == 0 {
            return 1;
        }
        let mut res = 10;
        let mut unique_digits = 9;
        let mut available_numbers = 9;
        for i in 2..=n {
            if available_numbers == 0 {
                break;
            }
            unique_digits *= available_numbers;
            res += unique_digits;
            available_numbers -= 1;
        }
        res
    }
}