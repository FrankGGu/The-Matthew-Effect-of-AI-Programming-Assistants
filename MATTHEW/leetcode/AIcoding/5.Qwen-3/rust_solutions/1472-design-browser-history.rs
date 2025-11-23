struct BrowserHistory {
    history: Vec<String>,
    current: usize,
}

impl BrowserHistory {
    fn new(homepage: String) -> Self {
        BrowserHistory {
            history: vec![homepage],
            current: 0,
        }
    }

    fn visit(&mut self, url: String) {
        self.history.truncate(self.current + 1);
        self.history.push(url);
        self.current = self.history.len() - 1;
    }

    fn back(&mut self, steps: i32) -> String {
        let steps = steps as usize;
        self.current = std::cmp::max(0, self.current.saturating_sub(steps));
        self.history[self.current].clone()
    }

    fn forward(&mut self, steps: i32) -> String {
        let steps = steps as usize;
        self.current = std::cmp::min(self.history.len() - 1, self.current + steps);
        self.history[self.current].clone()
    }
}