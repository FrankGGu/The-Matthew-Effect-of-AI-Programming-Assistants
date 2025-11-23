impl Solution {
    pub fn title_to_number(column_title: String) -> i32 {
        column_title.chars().rev().enumerate().map(|(i, c)| (c as i32 - 'A' as i32 + 1) * 26_i32.pow(i as u32)).sum()
    }
}