struct TextEditor {
    left: Vec<char>,
    right: Vec<char>,
}

impl TextEditor {
    fn new() -> Self {
        TextEditor {
            left: Vec::new(),
            right: Vec::new(),
        }
    }

    fn add_text(&mut self, text: String) {
        for c in text.chars() {
            self.left.push(c);
        }
    }

    fn delete_text(&mut self, k: i32) -> i32 {
        let mut deleted_count = 0;
        for _ in 0..k {
            if self.left.pop().is_some() {
                deleted_count += 1;
            } else {
                break;
            }
        }
        deleted_count
    }

    fn cursor_left(&mut self, k: i32) -> String {
        for _ in 0..k {
            if let Some(c) = self.left.pop() {
                self.right.push(c);
            } else {
                break;
            }
        }
        self.get_left_string()
    }

    fn cursor_right(&mut self, k: i32) -> String {
        for _ in 0..k {
            if let Some(c) = self.right.pop() {
                self.left.push(c);
            } else {
                break;
            }
        }
        self.get_left_string()
    }

    fn get_left_string(&self) -> String {
        let len = self.left.len();
        let start_idx = if len > 10 { len - 10 } else { 0 };
        self.left[start_idx..len].iter().collect()
    }
}