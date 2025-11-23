struct Solution;

impl Solution {
    pub fn prime_palindrome(n: i32) -> i32 {
        if n <= 2 {
            return 2;
        }
        if n <= 3 {
            return 3;
        }
        if n <= 5 {
            return 5;
        }
        if n <= 7 {
            return 7;
        }

        for i in (11..=1000000).step_by(2) {
            if is_prime(i) && is_palindrome(i) {
                if i >= n {
                    return i;
                }
            }
        }

        -1
    }
}

fn is_prime(x: i32) -> bool {
    if x % 2 == 0 {
        return false;
    }
    let sqrt_x = (x as f64).sqrt() as i32;
    for i in (3..=sqrt_x).step_by(2) {
        if x % i == 0 {
            return false;
        }
    }
    true
}

fn is_palindrome(x: i32) -> bool {
    let s = x.to_string();
    s == s.chars().rev().collect::<String>()
}