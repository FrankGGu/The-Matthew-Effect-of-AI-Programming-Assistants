pub struct TextEditor {
    text: String,
    cursor: usize,
}

impl TextEditor {
    pub fn new() -> Self {
        TextEditor {
            text: String::new(),
            cursor: 0,
        }
    }

    pub fn add_text(&mut self, text: String) {
        self.text.insert_str(self.cursor, &text);
        self.cursor += text.len();
    }

    pub fn delete_text(&mut self, k: i32) -> i32 {
        let k = k as usize;
        let start = if self.cursor < k { self.cursor } else { k };
        self.cursor -= start;
        self.text.drain(self.cursor..self.cursor + start);
        start as i32
    }

    pub fn cursor_left(&mut self, k: i32) -> String {
        let k = k as usize;
        self.cursor = if self.cursor < k {
            0
        } else {
            self.cursor - k
        };
        self.get_current_text()
    }

    pub fn cursor_right(&mut self, k: i32) -> String {
        let k = k as usize;
        self.cursor = if self.cursor + k > self.text.len() {
            self.text.len()
        } else {
            self.cursor + k
        };
        self.get_current_text()
    }

    fn get_current_text(&self) -> String {
        let start = if self.cursor > 10 { self.cursor - 10 } else { 0 };
        self.text[start..self.cursor].to_string()
    }
}