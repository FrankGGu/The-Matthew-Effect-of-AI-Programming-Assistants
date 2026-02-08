struct Solution;

impl Solution {
    fn is_prime(num: i32) -> bool {
        if num <= 1 {
            return false;
        }
        if num == 2 || num == 3 {
            return true;
        }
        if num % 2 == 0 || num % 3 == 0 {
            return false;
        }
        let mut i = 5;
        while i * i <= num {
            if num % i == 0 || num % (i + 2) == 0 {
                return false;
            }
            i += 6;
        }
        true
    }

    fn make_palindrome(num: i32) -> i32 {
        let s = num.to_string();
        let mut rev_s = String::new();
        for c in s.chars().rev().skip(1) {
            rev_s.push(c);
        }
        let p_str = format!("{}{}", s, rev_s);
        p_str.parse::<i32>().unwrap_or(i32::MAX)
    }

    pub fn prime_palindrome(n: i32) -> i32 {
        if n <= 2 {
            return 2;
        }
        if n == 3 {
            return 3;
        }
        if n <= 5 {
            return 5;
        }
        if n <= 7 {
            return 7;
        }
        if n <= 11 {
            return 11;
        }

        for i in 1..=22000 {
            let p = Self::make_palindrome(i);
            if p >= n && Self::is_prime(p) {
                return p;
            }
        }

        unreachable!()
    }
}