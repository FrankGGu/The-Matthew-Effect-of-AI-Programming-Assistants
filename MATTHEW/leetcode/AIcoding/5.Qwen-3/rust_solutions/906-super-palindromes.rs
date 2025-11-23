impl Solution {

use std::collections::HashSet;

struct Solution;

impl Solution {
    pub fn super_palindromes(mut l: i64, mut r: i64) -> Vec<i64> {
        let mut result = HashSet::new();
        let mut i = 1;
        while i < 100000 {
            let s = i.to_string();
            let s_rev = s.chars().rev().collect::<String>();
            let p = format!("{}{}", s, s_rev);
            let num: i64 = p.parse().unwrap();
            if num > r {
                break;
            }
            if num >= l && is_palindrome(num) {
                result.insert(num);
            }
            let p2 = format!("{}{}", s, s_rev.chars().rev().collect::<String>());
            let num2: i64 = p2.parse().unwrap();
            if num2 > r {
                break;
            }
            if num2 >= l && is_palindrome(num2) {
                result.insert(num2);
            }
            i += 1;
        }

        let mut res: Vec<i64> = result.into_iter().collect();
        res.sort();
        res
    }
}

fn is_palindrome(n: i64) -> bool {
    let s = n.to_string();
    s == s.chars().rev().collect::<String>()
}
}