pub fn number_of_lines(widths: Vec<i32>, s: String) -> Vec<i32> {
    let mut lines = 1;
    let mut current_width = 0;

    for c in s.chars() {
        let char_width = widths[(c as usize - 'a' as usize) as usize];
        if current_width + char_width > 100 {
            lines += 1;
            current_width = char_width;
        } else {
            current_width += char_width;
        }
    }

    vec![lines, current_width]
}