impl Solution {
    pub fn count_substrings(s: String) -> i32 {
        let n = s.len();
        let s = s.as_bytes();
        let mut count = 0;

        for i in 0..n {
            count += Solution::expand_around_center(s, i, i); // odd length
            count += Solution::expand_around_center(s, i, i + 1); // even length
        }

        count
    }

    fn expand_around_center(s: &[u8], left: usize, right: usize) -> i32 {
        let mut count = 0;
        let mut l = left;
        let mut r = right;

        while l < s.len() && r < s.len() && s[l] == s[r] {
            count += 1;
            if l == 0 { break; }
            l -= 1;
            r += 1;
        }

        count
    }
}