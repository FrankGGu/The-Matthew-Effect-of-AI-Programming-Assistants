impl Solution {
    pub fn count_substrings(s: String, c: char) -> i32 {
        let mut count = 0;
        let bytes = s.as_bytes();
        let n = bytes.len();

        for i in 0..n {
            if bytes[i] == c as u8 {
                let mut j = i;
                while j < n && i + j - i < n && bytes[j] == c as u8 {
                    count += 1;
                    j += 1;
                }
                let mut k = i;
                while k > 0 && i + k - i < n && bytes[k - 1] == c as u8 {
                    count += 1;
                    k -= 1;
                }
            }
        }
        count
    }
}