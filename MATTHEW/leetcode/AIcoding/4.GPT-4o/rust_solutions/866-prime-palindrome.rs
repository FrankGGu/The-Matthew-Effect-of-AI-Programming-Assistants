impl Solution {
    pub fn prime_palindrome(n: i32) -> i32 {
        fn is_prime(num: i32) -> bool {
            if num < 2 { return false; }
            for i in 2..=((num as f64).sqrt() as i32) {
                if num % i == 0 {
                    return false;
                }
            }
            true
        }

        fn is_palindrome(num: i32) -> bool {
            let s = num.to_string();
            s == s.chars().rev().collect::<String>()
        }

        let mut num = n;
        while num <= 100000000 {
            if is_palindrome(num) && is_prime(num) {
                return num;
            }
            num += 1;
        }
        0
    }
}