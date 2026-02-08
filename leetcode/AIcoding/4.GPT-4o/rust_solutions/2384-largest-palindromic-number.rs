impl Solution {
    pub fn largest_palindrome(n: i32) -> String {
        if n == 1 {
            return "9".to_string();
        }

        let upper = 10_i64.pow(n as u32) - 1;
        let lower = 10_i64.pow(n as u32 - 1);
        let mut max_palindrome = 0;

        for i in (lower..=upper).rev() {
            let palindrome = i.to_string() + &i.to_string().chars().rev().collect::<String>();
            let palindrome_num = palindrome.parse::<i64>().unwrap();
            if palindrome_num > max_palindrome {
                let mut count = 0;
                let mut temp = palindrome_num;
                for j in (lower..=upper).rev() {
                    if palindrome_num / j == palindrome_num % j {
                        count += 1;
                    }
                    if count == 2 {
                        max_palindrome = max_palindrome.max(palindrome_num);
                        break;
                    }
                }
            }
        }

        max_palindrome.to_string()
    }
}