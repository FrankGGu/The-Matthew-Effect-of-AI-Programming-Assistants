impl Solution {
    pub fn largest_palindrome(k: i32) -> i32 {
        let upper_limit = 10_i32.pow(k as u32) - 1;
        let lower_limit = 10_i32.pow(k as u32 - 1);
        let mut max_palindrome = 0;

        for i in (lower_limit..=upper_limit).rev() {
            let pal = i.to_string() + &i.to_string().chars().rev().collect::<String>();
            let pal_num = pal.parse::<i32>().unwrap();
            if pal_num < max_palindrome {
                break;
            }
            for j in (lower_limit..=upper_limit).rev() {
                if pal_num % j == 0 && pal_num / j >= lower_limit && pal_num / j <= upper_limit {
                    max_palindrome = max_palindrome.max(pal_num);
                    break;
                }
            }
        }
        max_palindrome % 1337
    }
}