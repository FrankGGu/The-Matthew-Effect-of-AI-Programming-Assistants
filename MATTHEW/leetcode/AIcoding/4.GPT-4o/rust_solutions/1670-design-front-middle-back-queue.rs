use std::collections::VecDeque;

struct FrontMiddleBackQueue {
    queue: VecDeque<i32>,
}

impl FrontMiddleBackQueue {
    fn new() -> Self {
        FrontMiddleBackQueue {
            queue: VecDeque::new(),
        }
    }

    fn push_front(&mut self, val: i32) {
        self.queue.push_front(val);
    }

    fn push_middle(&mut self, val: i32) {
        let mid = self.queue.len() / 2;
        self.queue.insert(mid, val);
    }

    fn push_back(&mut self, val: i32) {
        self.queue.push_back(val);
    }

    fn pop_front(&mut self) -> i32 {
        self.queue.pop_front().unwrap_or(-1)
    }

    fn pop_middle(&mut self) -> i32 {
        if self.queue.is_empty() {
            return -1;
        }
        let mid = (self.queue.len() - 1) / 2;
        self.queue.remove(mid).unwrap()
    }

    fn pop_back(&mut self) -> i32 {
        self.queue.pop_back().unwrap_or(-1)
    }
}