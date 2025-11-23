impl Solution {
    pub fn largest_palindrome(n: i32, k: i32) -> i32 {
        if n == 1 {
            for num in (1..=9).rev() {
                if num % k == 0 {
                    return num as i32 % 1337;
                }
            }
            return 0;
        }

        let upper_bound = 10_i64.pow(n as u32) - 1;
        let lower_bound = 10_i64.pow(n as u32 - 1);

        for i in (lower_bound..=upper_bound).rev() {
            let s_i = i.to_string();
            let reversed_s_i: String = s_i.chars().rev().collect();
            let palindrome_str = format!("{}{}", s_i, reversed_s_i);
            let palindrome: i64 = palindrome_str.parse().unwrap();

            if palindrome % k == 0 {
                for j in (lower_bound..=upper_bound).rev() {
                    if j * j < palindrome {
                        break;
                    }
                    if palindrome % j == 0 {
                        let other_factor = palindrome / j;
                        if other_factor >= lower_bound && other_factor <= upper_bound {
                            return (palindrome % 1337) as i32;
                        }
                    }
                }
            }
        }

        0
    }
}