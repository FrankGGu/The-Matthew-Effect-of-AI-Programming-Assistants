impl Solution {
    pub fn count_good_substrings(s: String) -> i32 {
        let mut count = 0;
        let bytes = s.as_bytes();
        for i in 0..s.len() - 2 {
            if bytes[i] != bytes[i + 1] && bytes[i] != bytes[i + 2] && bytes[i + 1] != bytes[i + 2] {
                count += 1;
            }
        }
        count
    }
}