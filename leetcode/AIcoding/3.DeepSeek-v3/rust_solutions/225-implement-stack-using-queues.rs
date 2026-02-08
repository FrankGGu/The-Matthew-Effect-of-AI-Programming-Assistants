use std::collections::VecDeque;

struct MyStack {
    queue: VecDeque<i32>,
}

impl MyStack {
    fn new() -> Self {
        MyStack {
            queue: VecDeque::new(),
        }
    }

    fn push(&mut self, x: i32) {
        let mut n = self.queue.len();
        self.queue.push_back(x);
        while n > 0 {
            let val = self.queue.pop_front().unwrap();
            self.queue.push_back(val);
            n -= 1;
        }
    }

    fn pop(&mut self) -> i32 {
        self.queue.pop_front().unwrap()
    }

    fn top(&self) -> i32 {
        *self.queue.front().unwrap()
    }

    fn empty(&self) -> bool {
        self.queue.is_empty()
    }
}