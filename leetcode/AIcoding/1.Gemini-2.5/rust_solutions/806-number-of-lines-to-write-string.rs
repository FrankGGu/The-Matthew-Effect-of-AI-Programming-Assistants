impl Solution {
    pub fn number_of_lines(widths: Vec<i32>, s: String) -> Vec<i32> {
        let mut lines = 1;
        let mut current_line_width = 0;

        for c in s.chars() {
            let char_width = widths[(c as u8 - b'a') as usize];
            if current_line_width + char_width > 100 {
                lines += 1;
                current_line_width = char_width;
            } else {
                current_line_width += char_width;
            }
        }

        vec![lines, current_line_width]
    }
}