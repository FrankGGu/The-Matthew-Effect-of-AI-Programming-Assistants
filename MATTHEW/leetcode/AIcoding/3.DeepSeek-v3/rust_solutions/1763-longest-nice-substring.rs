impl Solution {
    pub fn longest_nice_substring(s: String) -> String {
        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        let mut max_len = 0;
        let mut res = String::new();

        for i in 0..n {
            let mut lower = 0;
            let mut upper = 0;
            for j in i..n {
                let c = chars[j];
                if c.is_lowercase() {
                    lower |= 1 << (c as u8 - b'a');
                } else {
                    upper |= 1 << (c as u8 - b'A');
                }
                if lower == upper && j - i + 1 > max_len {
                    max_len = j - i + 1;
                    res = chars[i..=j].iter().collect();
                }
            }
        }
        res
    }
}