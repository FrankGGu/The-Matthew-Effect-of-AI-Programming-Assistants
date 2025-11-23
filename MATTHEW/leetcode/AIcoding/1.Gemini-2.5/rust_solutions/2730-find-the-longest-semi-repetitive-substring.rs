impl Solution {
    pub fn longest_semi_repetitive_substring(s: String) -> i32 {
        let n = s.len();
        if n <= 2 {
            return n as i32;
        }

        let chars = s.as_bytes();
        let mut left = 0;
        let mut count_pairs = 0;
        let mut max_len = 2;

        for right in 0..n {
            if right > 0 && chars[right] == chars[right - 1] {
                count_pairs += 1;
            }

            while count_pairs > 1 {
                if chars[left] == chars[left + 1] {
                    count_pairs -= 1;
                }
                left += 1;
            }

            max_len = std::cmp::max(max_len, (right - left + 1) as i32);
        }

        max_len
    }
}