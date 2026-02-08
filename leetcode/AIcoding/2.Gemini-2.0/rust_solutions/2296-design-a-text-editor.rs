struct TextEditor {
    left: String,
    right: String,
}

impl TextEditor {
    fn new() -> Self {
        TextEditor {
            left: String::new(),
            right: String::new(),
        }
    }

    fn add_text(&mut self, text: String) {
        self.left.push_str(&text);
    }

    fn delete_text(&mut self, k: i32) -> i32 {
        let k = k as usize;
        let len = self.left.len();
        let delete_count = std::cmp::min(k, len);
        self.left.truncate(len - delete_count);
        delete_count as i32
    }

    fn cursor_left(&mut self, k: i32) -> String {
        let k = k as usize;
        let len = self.left.len();
        let move_count = std::cmp::min(k, len);

        let mut temp = self.left.split_off(len - move_count);
        self.right = temp + &self.right;

        let preview_len = std::cmp::min(10, self.left.len());
        self.left.split_off(self.left.len() - preview_len)
    }

    fn cursor_right(&mut self, k: i32) -> String {
        let k = k as usize;
        let len = self.right.len();
        let move_count = std::cmp::min(k, len);

        let mut temp = self.right.split_off(0);
        let (moved, remaining) = temp.split_at(move_count);

        self.left.push_str(moved);
        self.right = remaining.to_string();

        let preview_len = std::cmp::min(10, self.left.len());
        self.left.split_off(self.left.len() - preview_len)
    }
}