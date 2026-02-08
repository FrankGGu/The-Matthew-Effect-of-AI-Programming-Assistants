impl Solution {
    pub fn superpalindromes_in_range(left: String, right: String) -> i32 {
        let l = left.parse::<i64>().unwrap();
        let r = right.parse::<i64>().unwrap();
        let mut count = 0;

        for i in 1..100000 {
            let mut s = i.to_string();
            let mut t = s.chars().rev().collect::<String>();
            let mut num = s.clone() + &t;
            let n = num.parse::<i64>().unwrap();
            let sq = n * n;
            if sq >= l && sq <= r && Solution::is_palindrome(sq) {
                count += 1;
            }

            s = i.to_string();
            t = s.chars().rev().skip(1).collect::<String>();
            num = s.clone() + &t;
            let n = num.parse::<i64>().unwrap();
            let sq = n * n;
            if sq >= l && sq <= r && Solution::is_palindrome(sq) {
                count += 1;
            }
        }

        count
    }

    fn is_palindrome(n: i64) -> bool {
        let s = n.to_string();
        let t = s.chars().rev().collect::<String>();
        s == t
    }
}