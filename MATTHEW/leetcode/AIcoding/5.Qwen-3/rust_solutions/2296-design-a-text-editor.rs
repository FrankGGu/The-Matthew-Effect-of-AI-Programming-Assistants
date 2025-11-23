struct TextEditor {
    left: Vec<char>,
    right: Vec<char>,
}

impl TextEditor {
    fn new() -> Self {
        TextEditor { left: Vec::new(), right: Vec::new() }
    }

    fn add_text(&mut self, text: String) {
        for c in text.chars() {
            self.left.push(c);
        }
    }

    fn delete_text(&mut self, k: i64) -> i64 {
        let k = k as usize;
        let len = self.left.len();
        if k >= len {
            let deleted = len as i64;
            self.left.clear();
            return deleted;
        } else {
            let deleted = k as i64;
            self.left.truncate(len - k);
            return deleted;
        }
    }

    fn cursor_left(&mut self, k: i64) -> i64 {
        let k = k as usize;
        let len = self.left.len();
        let move_len = std::cmp::min(k, len);
        let mut moved = move_len as i64;
        for _ in 0..move_len {
            self.right.push(self.left.pop().unwrap());
        }
        return moved;
    }

    fn cursor_right(&mut self, k: i64) -> i64 {
        let k = k as usize;
        let len = self.right.len();
        let move_len = std::cmp::min(k, len);
        let mut moved = move_len as i64;
        for _ in 0..move_len {
            self.left.push(self.right.pop().unwrap());
        }
        return moved;
    }

    fn get_text(&self) -> String {
        self.left.iter().chain(self.right.iter()).collect()
    }
}