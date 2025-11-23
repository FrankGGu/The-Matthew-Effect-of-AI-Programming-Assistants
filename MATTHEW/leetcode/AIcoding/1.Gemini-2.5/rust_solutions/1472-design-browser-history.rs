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
        self.current_index = self.history.len() - 1;
    }

    fn back(&mut self, steps: i32) -> String {
        self.current_index = self.current_index.saturating_sub(steps as usize);
        self.history[self.current_index].clone()
    }

    fn forward(&mut self, steps: i32) -> String {
        let max_index = self.history.len() - 1;
        self.current_index = (self.current_index + steps as usize).min(max_index);
        self.history[self.current_index].clone()
    }
}