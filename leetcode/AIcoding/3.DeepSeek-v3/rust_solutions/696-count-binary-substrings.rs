impl Solution {
    pub fn count_binary_substrings(s: String) -> i32 {
        let s = s.as_bytes();
        let mut prev = 0;
        let mut curr = 1;
        let mut res = 0;

        for i in 1..s.len() {
            if s[i] == s[i - 1] {
                curr += 1;
            } else {
                res += std::cmp::min(prev, curr);
                prev = curr;
                curr = 1;
            }
        }
        res + std::cmp::min(prev, curr)
    }
}