use std::collections::VecDeque;

struct FrontMiddleBackQueue {
    left: VecDeque<i32>,
    right: VecDeque<i32>,
}

impl FrontMiddleBackQueue {
    fn new() -> Self {
        FrontMiddleBackQueue {
            left: VecDeque::new(),
            right: VecDeque::new(),
        }
    }

    fn balance(&mut self) {
        // Ensure left.len() is either equal to right.len() or right.len() + 1
        // If left is too long
        while self.left.len() > self.right.len() + 1 {
            if let Some(val) = self.left.pop_back() {
                self.right.push_front(val);
            }
        }
        // If right is too long
        while self.right.len() > self.left.len() {
            if let Some(val) = self.right.pop_front() {
                self.left.push_back(val);
            }
        }
    }

    fn push_front(&mut self, val: i32) {
        self.left.push_front(val);
        self.balance();
    }

    fn push_middle(&mut self, val: i32) {
        self.left.push_back(val);
        self.balance();
    }

    fn push_back(&mut self, val: i32) {
        self.right.push_back(val);
        self.balance();
    }

    fn pop_front(&mut self) -> i32 {
        if self.left.is_empty() {
            return -1;
        }
        let res = self.left.pop_front().unwrap();
        self.balance();
        res
    }

    fn pop_middle(&mut self) -> i32 {
        if self.left.is_empty() {
            return -1;
        }
        let res = self.left.pop_back().unwrap();
        self.balance();
        res
    }

    fn pop_back(&mut self) -> i32 {
        if self.left.is_empty() {
            return -1;
        }
        let res = if !self.right.is_empty() {
            self.right.pop_back().unwrap()
        } else {
            self.left.pop_back().unwrap()
        };
        self.balance();
        res
    }
}