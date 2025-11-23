struct Solution;

impl Solution {
    pub fn longest_palindrome(s: String) -> String {
        if s.len() <= 1 {
            return s;
        }

        let mut start = 0;
        let mut end = 0;

        for i in 0..s.len() {
            let len1 = Self::expand_around_center(&s, i, i);
            let len2 = Self::expand_around_center(&s, i, i + 1);
            let max_len = std::cmp::max(len1, len2);

            if max_len > (end - start) {
                start = i - (max_len - 1) / 2;
                end = i + max_len / 2;
            }
        }

        s[start..end + 1].to_string()
    }

    fn expand_around_center(s: &str, left: usize, right: usize) -> usize {
        let mut l = left;
        let mut r = right;

        while l < s.len() && r < s.len() && s.as_bytes()[l] == s.as_bytes()[r] {
            l -= 1;
            r += 1;
        }

        (r - l - 1)
    }
}