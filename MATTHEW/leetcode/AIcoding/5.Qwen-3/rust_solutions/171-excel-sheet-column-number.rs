struct Solution {}

impl Solution {
    pub fn title_to_number(s: String) -> i32 {
        let mut result = 0;
        for c in s.chars() {
            let val = c as i32 - 'A' as i32 + 1;
            result = result * 26 + val;
        }
        result
    }
}