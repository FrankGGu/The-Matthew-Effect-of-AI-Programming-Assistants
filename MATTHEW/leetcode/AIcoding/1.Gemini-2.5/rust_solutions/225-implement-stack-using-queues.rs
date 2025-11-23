use std::collections::VecDeque;

struct MyStack {
    q1: VecDeque<i32>,
    q2: VecDeque<i32>,
}

impl MyStack {
    fn new() -> Self {
        MyStack {
            q1: VecDeque::new(),
            q2: VecDeque::new(),
        }
    }

    fn push(&mut self, x: i32) {
        self.q1.push_back(x);
    }

    fn pop(&mut self) -> i32 {
        while self.q1.len() > 1 {
            self.q2.push_back(self.q1.pop_front().unwrap());
        }
        let val = self.q1.pop_front().unwrap();
        std::mem::swap(&mut self.q1, &mut self.q2);
        val
    }

    fn top(&mut self) -> i32 {
        while self.q1.len() > 1 {
            self.q2.push_back(self.q1.pop_front().unwrap());
        }
        let val = *self.q1.front().unwrap();
        self.q2.push_back(self.q1.pop_front().unwrap());
        std::mem::swap(&mut self.q1, &mut self.q2);
        val
    }

    fn empty(&self) -> bool {
        self.q1.is_empty()
    }
}