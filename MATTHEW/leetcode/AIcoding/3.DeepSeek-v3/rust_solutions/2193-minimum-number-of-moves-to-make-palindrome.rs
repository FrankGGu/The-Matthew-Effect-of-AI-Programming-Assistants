impl Solution {
    pub fn min_moves_to_make_palindrome(s: String) -> i32 {
        let mut s = s.into_bytes();
        let mut res = 0;
        let mut left = 0;
        let mut right = s.len() - 1;

        while left < right {
            if s[left] == s[right] {
                left += 1;
                right -= 1;
                continue;
            }

            let mut k = right;
            while k > left && s[k] != s[left] {
                k -= 1;
            }

            if k == left {
                s.swap(left, left + 1);
                res += 1;
            } else {
                for i in k..right {
                    s.swap(i, i + 1);
                    res += 1;
                }
                left += 1;
                right -= 1;
            }
        }

        res
    }
}