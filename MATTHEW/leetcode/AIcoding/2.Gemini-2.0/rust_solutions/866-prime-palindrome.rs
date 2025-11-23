impl Solution {
    pub fn prime_palindrome(n: i32) -> i32 {
        let mut n = n;
        while true {
            if n > 1 && Solution::is_palindrome(n) && Solution::is_prime(n) {
                return n;
            }
            if n > 9989999 {
                return 100030001;
            }
            n += 1;
        }
    }

    fn is_palindrome(n: i32) -> bool {
        let s = n.to_string();
        let s_rev: String = s.chars().rev().collect();
        s == s_rev
    }

    fn is_prime(n: i32) -> bool {
        if n <= 1 {
            return false;
        }
        let mut i = 2;
        while i * i <= n {
            if n % i == 0 {
                return false;
            }
            i += 1;
        }
        true
    }
}