impl Solution {
    pub fn longest_palindrome(s: String) -> String {
        let bytes = s.as_bytes();
        let n = bytes.len();
        let mut start = 0;
        let mut max_len = 1;

        for i in 0..n {
            let (len1, len2) = (Self::expand_around_center(bytes, i, i), Self::expand_around_center(bytes, i, i + 1));
            let len = len1.max(len2);
            if len > max_len {
                max_len = len;
                start = i - (max_len - 1) / 2;
            }
        }

        s[start..start + max_len].to_string()
    }

    fn expand_around_center(bytes: &[u8], left: usize, right: usize) -> usize {
        let mut l = left;
        let mut r = right;
        while l >= 0 && r < bytes.len() && bytes[l] == bytes[r] {
            l = l.checked_sub(1).unwrap_or(usize::MAX);
            r += 1;
        }
        r - l - 1
    }
}