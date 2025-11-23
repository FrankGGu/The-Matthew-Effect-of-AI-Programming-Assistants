impl Solution {
    pub fn largest_palindrome(n: i32, k: i32) -> String {
        if n == 1 {
            if k > 9 {
                return "9".to_string();
            } else {
                return (k - 1).to_string();
            }
        }

        let max_num = 10_i64.pow(n as u32) - 1;
        let min_num = 10_i64.pow((n - 1) as u32);

        for i in (1..=(max_num / k)).rev() {
            let num = i * k as i64;
            if num > max_num {
                continue;
            }

            let s = num.to_string();
            if s.len() != n as usize {
                continue;
            }

            let s_rev: String = s.chars().rev().collect();
            if s == s_rev {
                return s;
            }
        }
        return "-1".to_string();
    }
}