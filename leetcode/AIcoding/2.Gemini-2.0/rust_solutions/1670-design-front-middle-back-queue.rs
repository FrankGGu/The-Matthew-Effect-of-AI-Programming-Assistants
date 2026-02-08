struct FrontMiddleBackQueue {
    front: VecDeque<i32>,
    back: VecDeque<i32>,
}

use std::collections::VecDeque;

impl FrontMiddleBackQueue {
    fn new() -> Self {
        FrontMiddleBackQueue {
            front: VecDeque::new(),
            back: VecDeque::new(),
        }
    }

    fn push_front(&mut self, val: i32) {
        self.front.push_front(val);
        self.balance();
    }

    fn push_middle(&mut self, val: i32) {
        if self.front.len() == self.back.len() {
            self.back.push_front(val);
        } else {
            self.front.push_back(val);
        }
    }

    fn push_back(&mut self, val: i32) {
        self.back.push_back(val);
        self.balance();
    }

    fn pop_front(&mut self) -> i32 {
        if self.front.is_empty() && self.back.is_empty() {
            return -1;
        }
        if self.front.is_empty() {
            return self.back.pop_front().unwrap();
        }
        let val = self.front.pop_front().unwrap();
        self.balance();
        val
    }

    fn pop_middle(&mut self) -> i32 {
        if self.front.is_empty() && self.back.is_empty() {
            return -1;
        }
        if self.front.len() == self.back.len() {
            return self.front.pop_back().unwrap();
        } else {
            return self.back.pop_front().unwrap();
        }
    }

    fn pop_back(&mut self) -> i32 {
        if self.front.is_empty() && self.back.is_empty() {
            return -1;
        }
        if self.back.is_empty() {
            return self.front.pop_back().unwrap();
        }
        let val = self.back.pop_back().unwrap();
        self.balance();
        val
    }

    fn balance(&mut self) {
        while self.front.len() > self.back.len() + 1 {
            self.back.push_front(self.front.pop_back().unwrap());
        }
        while self.back.len() > self.front.len() {
            self.front.push_back(self.back.pop_front().unwrap());
        }
    }
}