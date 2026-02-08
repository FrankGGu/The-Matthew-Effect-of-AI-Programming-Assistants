impl Solution {
    pub fn count_substrings(s: String, c: char) -> i64 {
        let mut count = 0;
        for ch in s.chars() {
            if ch == c {
                count += 1;
            }
        }
        count * (count + 1) / 2
    }
}