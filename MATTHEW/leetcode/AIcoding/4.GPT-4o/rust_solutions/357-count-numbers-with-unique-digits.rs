impl Solution {
    pub fn count_numbers_with_unique_digits(n: i32) -> i32 {
        if n == 0 {
            return 1;
        }
        if n == 1 {
            return 10;
        }
        let mut count = 10;
        let mut unique_digits = 9;
        let mut available_numbers = 9;

        for i in 2..=n {
            unique_digits *= available_numbers;
            count += unique_digits;
            available_numbers -= 1;
        }
        count
    }
}