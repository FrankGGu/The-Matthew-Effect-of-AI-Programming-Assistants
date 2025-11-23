use std::collections::VecDeque;

struct FrontMiddleBackQueue {
    front: VecDeque<i32>,
    back: VecDeque<i32>,
}

impl FrontMiddleBackQueue {
    fn new() -> Self {
        FrontMiddleBackQueue {
            front: VecDeque::new(),
            back: VecDeque::new(),
        }
    }

    fn balance(&mut self) {
        while self.front.len() > self.back.len() {
            if let Some(val) = self.front.pop_back() {
                self.back.push_front(val);
            }
        }
        while self.back.len() > self.front.len() + 1 {
            if let Some(val) = self.back.pop_front() {
                self.front.push_back(val);
            }
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
        let val = if self.front.is_empty() {
            self.back.pop_front().unwrap()
        } else {
            self.front.pop_front().unwrap()
        };
        self.balance();
        val
    }

    fn pop_middle(&mut self) -> i32 {
        if self.front.is_empty() && self.back.is_empty() {
            return -1;
        }
        let val = if self.front.len() == self.back.len() {
            self.front.pop_back().unwrap()
        } else {
            self.back.pop_front().unwrap()
        };
        self.balance();
        val
    }

    fn pop_back(&mut self) -> i32 {
        if self.back.is_empty() {
            return -1;
        }
        let val = self.back.pop_back().unwrap();
        self.balance();
        val
    }
}