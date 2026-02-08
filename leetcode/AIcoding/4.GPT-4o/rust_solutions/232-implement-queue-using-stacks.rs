struct MyQueue {
    stack1: Vec<i32>,
    stack2: Vec<i32>,
}

impl MyQueue {
    fn new() -> Self {
        MyQueue {
            stack1: Vec::new(),
            stack2: Vec::new(),
        }
    }

    fn push(&mut self, x: i32) {
        self.stack1.push(x);
    }

    fn pop(&mut self) -> i32 {
        self.peek();
        self.stack2.pop().unwrap()
    }

    fn peek(&mut self) -> i32 {
        if self.stack2.is_empty() {
            while let Some(x) = self.stack1.pop() {
                self.stack2.push(x);
            }
        }
        *self.stack2.last().unwrap()
    }

    fn empty(&self) -> bool {
        self.stack1.is_empty() && self.stack2.is_empty()
    }
}