impl Solution {
    pub fn largest_odd_number(num: String) -> String {
        let mut i = num.len() - 1;
        while i > 0 && (num.as_bytes()[i] as char) % 2 == 0 {
            i -= 1;
        }
        num[..=i].to_string()
    }
}