impl Solution {
    pub fn largest_string_from_box(boxes: Vec<Vec<String>>) -> String {
        let mut max_str = String::new();
        for row in boxes {
            for s in row {
                if s.chars().all(|c| c.is_ascii_lowercase()) {
                    if s > max_str {
                        max_str = s;
                    }
                }
            }
        }
        max_str
    }
}