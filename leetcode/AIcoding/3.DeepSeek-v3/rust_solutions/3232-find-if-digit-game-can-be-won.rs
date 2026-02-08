impl Solution {
    pub fn sum_of_digits(mut num: i32) -> i32 {
        let mut sum = 0;
        while num > 0 {
            sum += num % 10;
            num /= 10;
        }
        sum
    }

    pub fn can_win_game(num: i32) -> bool {
        let sum = Self::sum_of_digits(num);
        sum % 2 != 1
    }
}