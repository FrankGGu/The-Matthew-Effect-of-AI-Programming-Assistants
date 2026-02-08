impl Solution {
    pub fn superpalindromes_in_range(left: String, right: String) -> i32 {
        let left: u64 = left.parse().unwrap();
        let right: u64 = right.parse().unwrap();
        let mut count = 0;

        let max = (right as f64).sqrt() as u64;
        for i in 1..=max {
            let s = i.to_string();
            let p = s.clone() + &s.chars().rev().collect::<String>();
            let palindrome = p.parse::<u64>().unwrap();
            let super_palindrome = palindrome * palindrome;

            if super_palindrome > right {
                break;
            }
            if super_palindrome >= left && super_palindrome.is_palindrome() {
                count += 1;
            }
        }

        for i in 1..=max {
            let s = i.to_string();
            let p = s.clone() + &s.chars().rev().collect::<String>().chars().skip(1).collect::<String>();
            let palindrome = p.parse::<u64>().unwrap();
            let super_palindrome = palindrome * palindrome;

            if super_palindrome > right {
                break;
            }
            if super_palindrome >= left && super_palindrome.is_palindrome() {
                count += 1;
            }
        }

        count
    }
}

trait IsPalindrome {
    fn is_palindrome(&self) -> bool;
}

impl IsPalindrome for u64 {
    fn is_palindrome(&self) -> bool {
        let s = self.to_string();
        s == s.chars().rev().collect::<String>()
    }
}