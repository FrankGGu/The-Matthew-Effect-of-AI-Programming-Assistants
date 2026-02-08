impl Solution {
    pub fn superpalindromes_in_range(left: String, right: String) -> i32 {
        let l: u64 = left.parse().unwrap();
        let r: u64 = right.parse().unwrap();

        let mut count = 0;

        for k in 1..100000 {
            let s = k.to_string();
            let rev_s: String = s.chars().rev().collect();
            let palindrome1: u64 = format!("{}{}", s, rev_s).parse().unwrap();
            let square1 = palindrome1 * palindrome1;
            if square1 > r {
                break;
            }
            if square1 >= l && is_palindrome(square1) {
                count += 1;
            }
        }

        for k in 1..100000 {
            let s = k.to_string();
            let rev_s: String = s.chars().rev().collect();
            let palindrome2: u64 = format!("{}{}", s, &rev_s[1..]).parse().unwrap();
            let square2 = palindrome2 * palindrome2;
            if square2 > r {
                break;
            }
            if square2 >= l && is_palindrome(square2) {
                count += 1;
            }
        }

        count
    }
}

fn is_palindrome(x: u64) -> bool {
    let s = x.to_string();
    s == s.chars().rev().collect::<String>()
}