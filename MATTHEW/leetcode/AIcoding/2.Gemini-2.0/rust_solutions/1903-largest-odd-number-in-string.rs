impl Solution {
    pub fn largest_odd_number(num: String) -> String {
        for i in (0..num.len()).rev() {
            if (num.as_bytes()[i] as char).to_digit(10).unwrap() % 2 != 0 {
                return num[0..i + 1].to_string();
            }
        }
        return "".to_string();
    }
}