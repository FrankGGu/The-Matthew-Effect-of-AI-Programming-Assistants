impl Solution {
    pub fn largest_odd_number(num: String) -> String {
        let num_bytes = num.as_bytes();
        for i in (0..num_bytes.len()).rev() {
            if (num_bytes[i] - b'0') % 2 == 1 {
                return num[..=i].to_string();
            }
        }
        String::new()
    }
}