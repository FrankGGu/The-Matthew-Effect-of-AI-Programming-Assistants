struct BrowserHistory {
    history: Vec<String>,
    current_index: usize,
}

impl BrowserHistory {
    fn new(homepage: String) -> Self {
        BrowserHistory {
            history: vec![homepage],
            current_index: 0,
        }
    }

    fn visit(&mut self, url: String) {
        self.history.truncate(self.current_index + 1);
        self.history.push(url);
        self.current_index += 1;
    }

    fn back(&mut self, steps: i32) -> String {
        let steps = steps as usize;
        if steps > self.current_index {
            self.current_index = 0;
        } else {
            self.current_index -= steps;
        }
        self.history[self.current_index].clone()
    }

    fn forward(&mut self, steps: i32) -> String {
        let steps = steps as usize;
        if self.current_index + steps >= self.history.len() {
            self.current_index = self.history.len() - 1;
        } else {
            self.current_index += steps;
        }
        self.history[self.current_index].clone()
    }
}