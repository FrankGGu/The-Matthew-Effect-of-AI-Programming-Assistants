impl Solution {
    pub fn count_numbers_with_unique_digits(n: i32) -> i32 {
        if n == 0 {
            return 1;
        }
        if n > 10 {
            return Solution::count_numbers_with_unique_digits(10);
        }

        let mut ans = 10;
        let mut product = 9;
        for i in 2..=n {
            product *= (11 - i);
            ans += product;
        }

        ans
    }
}