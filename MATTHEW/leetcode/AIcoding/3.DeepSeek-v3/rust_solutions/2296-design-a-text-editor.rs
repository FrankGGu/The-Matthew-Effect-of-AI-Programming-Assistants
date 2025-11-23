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
        let mut count = 0;
        for _ in 0..k {
            if self.left.pop().is_some() {
                count += 1;
            } else {
                break;
            }
        }
        count
    }

    fn cursor_left(&mut self, k: i32) -> String {
        let mut k = k as usize;
        while k > 0 && !self.left.is_empty() {
            let c = self.left.pop().unwrap();
            self.right.push(c);
            k -= 1;
        }
        self.left_string()
    }

    fn cursor_right(&mut self, k: i32) -> String {
        let mut k = k as usize;
        while k > 0 && !self.right.is_empty() {
            let c = self.right.pop().unwrap();
            self.left.push(c);
            k -= 1;
        }
        self.left_string()
    }

    fn left_string(&self) -> String {
        let start = if self.left.len() > 10 {
            self.left.len() - 10
        } else {
            0
        };
        self.left[start..].iter().collect()
    }
}