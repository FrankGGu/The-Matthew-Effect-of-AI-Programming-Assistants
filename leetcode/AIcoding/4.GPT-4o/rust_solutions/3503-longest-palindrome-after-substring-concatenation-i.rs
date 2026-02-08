impl Solution {
    pub fn longest_palindrome(s: String) -> String {
        let n = s.len();
        if n == 0 {
            return "".to_string();
        }
        let mut start = 0;
        let mut max_len = 1;

        let chars: Vec<char> = s.chars().collect();

        for i in 0..n {
            let mut left = i as i32;
            let mut right = i as i32;

            while left >= 0 && right < n as i32 && chars[left as usize] == chars[right as usize] {
                if right - left + 1 > max_len {
                    start = left;
                    max_len = right - left + 1;
                }
                left -= 1;
                right += 1;
            }

            left = i as i32;
            right = i as i32 + 1;

            while left >= 0 && right < n as i32 && chars[left as usize] == chars[right as usize] {
                if right - left + 1 > max_len {
                    start = left;
                    max_len = right - left + 1;
                }
                left -= 1;
                right += 1;
            }
        }

        chars[start as usize..start as usize + max_len].iter().collect()
    }
}