impl Solution {
    pub fn largest_odd_number(num: String) -> String {
        for i in (0..num.len()).rev() {
            let digit = num.as_bytes()[i];
            if (digit - b'0') % 2 != 0 {
                return num[0..=i].to_string();
            }
        }
        "".to_string()
    }
}