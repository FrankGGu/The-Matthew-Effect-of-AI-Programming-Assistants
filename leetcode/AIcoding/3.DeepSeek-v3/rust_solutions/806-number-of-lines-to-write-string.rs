impl Solution {
    pub fn number_of_lines(widths: Vec<i32>, s: String) -> Vec<i32> {
        let mut lines = 1;
        let mut current_width = 0;
        for c in s.chars() {
            let width = widths[(c as u8 - b'a') as usize];
            if current_width + width > 100 {
                lines += 1;
                current_width = width;
            } else {
                current_width += width;
            }
        }
        vec![lines, current_width]
    }
}