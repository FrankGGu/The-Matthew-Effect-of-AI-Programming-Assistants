impl Solution {
    pub fn count_numbers_with_unique_digits(n: i32) -> i32 {
        if n == 0 {
            return 1;
        }

        let mut ans = 10;
        let mut current_unique_count = 9;
        let mut available_digits = 9;

        for _k in 2..=n {
            current_unique_count *= available_digits;
            ans += current_unique_count;
            available_digits -= 1;
            if available_digits == 0 {
                break;
            }
        }

        ans
    }
}