impl Solution {
    pub fn longest_decomposition(s: String) -> i32 {
        let n = s.len();
        if n == 0 {
            return 0;
        }

        let s_bytes = s.as_bytes();
        let mut left = 0;
        let mut right = n - 1;
        let mut count = 0;

        while left <= right {
            let mut len = 1;
            while left + len - 1 < right - len + 1 {
                if s_bytes[left..left + len] == s_bytes[right - len + 1..right + 1] {
                    count += 2;
                    left += len;
                    right -= len;
                    break;
                }
                len += 1;
            }

            if left + len - 1 >= right - len + 1 {
                if left <= right {
                    count += 1;
                }
                break;
            }
        }

        count
    }
}