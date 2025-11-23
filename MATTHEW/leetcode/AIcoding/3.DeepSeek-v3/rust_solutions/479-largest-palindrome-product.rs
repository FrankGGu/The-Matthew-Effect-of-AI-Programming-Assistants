impl Solution {
    pub fn largest_palindrome(n: i32) -> i32 {
        if n == 1 {
            return 9;
        }
        let upper = 10_i64.pow(n as u32) - 1;
        let lower = upper / 10;
        for i in (lower..upper).rev() {
            let palindrome = Self::create_palindrome(i);
            let mut j = upper;
            while j * j >= palindrome {
                if palindrome % j == 0 && palindrome / j <= upper {
                    return (palindrome % 1337) as i32;
                }
                j -= 1;
            }
        }
        -1
    }

    fn create_palindrome(num: i64) -> i64 {
        let s = num.to_string();
        let rev_s: String = s.chars().rev().collect();
        (s + &rev_s).parse().unwrap()
    }
}