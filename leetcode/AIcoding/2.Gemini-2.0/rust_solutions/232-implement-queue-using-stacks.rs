struct MyQueue {
    s1: Vec<i32>,
    s2: Vec<i32>,
}

impl MyQueue {
    fn new() -> Self {
        MyQueue {
            s1: Vec::new(),
            s2: Vec::new(),
        }
    }

    fn push(&mut self, x: i32) {
        self.s1.push(x);
    }

    fn pop(&mut self) -> i32 {
        if self.s2.is_empty() {
            while !self.s1.is_empty() {
                self.s2.push(self.s1.pop().unwrap());
            }
        }
        self.s2.pop().unwrap()
    }

    fn peek(&mut self) -> i32 {
        if self.s2.is_empty() {
            while !self.s1.is_empty() {
                self.s2.push(self.s1.pop().unwrap());
            }
        }
        *self.s2.last().unwrap()
    }

    fn empty(&self) -> bool {
        self.s1.is_empty() && self.s2.is_empty()
    }
}