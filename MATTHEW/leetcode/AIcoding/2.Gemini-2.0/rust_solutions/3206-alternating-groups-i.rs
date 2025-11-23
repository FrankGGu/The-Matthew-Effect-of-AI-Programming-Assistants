impl Solution {
    pub fn alternating_groups(s: String) -> i32 {
        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        if n == 0 {
            return 0;
        }

        let mut max_len = 1;
        let mut current_len = 1;

        for i in 1..n {
            if chars[i] != chars[i - 1] {
                current_len += 1;
                max_len = max_len.max(current_len);
            } else {
                current_len = 1;
            }
        }

        max_len
    }
}