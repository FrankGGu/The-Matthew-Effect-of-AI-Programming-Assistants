impl Solution {
    pub fn largest_palindrome(n: i32) -> i32 {
        if n == 1 {
            return 9;
        }

        let upper_limit = 10_i32.pow(n as u32) - 1;
        let lower_limit = 10_i32.pow((n - 1) as u32);
        let mut max_palindrome = 0;

        for i in (lower_limit..=upper_limit).rev() {
            for j in (lower_limit..=upper_limit).rev() {
                let product = i * j;
                if product <= max_palindrome {
                    break;
                }
                if Self::is_palindrome(product) {
                    max_palindrome = max_palindrome.max(product % 1337);
                }
            }
        }
        max_palindrome
    }

    fn is_palindrome(num: i32) -> bool {
        let s = num.to_string();
        s.chars().eq(s.chars().rev())
    }
}