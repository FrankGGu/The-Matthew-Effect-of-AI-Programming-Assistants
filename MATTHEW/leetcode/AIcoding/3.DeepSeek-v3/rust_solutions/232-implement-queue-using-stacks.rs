struct MyQueue {
    stack_in: Vec<i32>,
    stack_out: Vec<i32>,
}

impl MyQueue {
    fn new() -> Self {
        MyQueue {
            stack_in: Vec::new(),
            stack_out: Vec::new(),
        }
    }

    fn push(&mut self, x: i32) {
        self.stack_in.push(x);
    }

    fn pop(&mut self) -> i32 {
        if self.stack_out.is_empty() {
            while let Some(val) = self.stack_in.pop() {
                self.stack_out.push(val);
            }
        }
        self.stack_out.pop().unwrap()
    }

    fn peek(&mut self) -> i32 {
        if self.stack_out.is_empty() {
            while let Some(val) = self.stack_in.pop() {
                self.stack_out.push(val);
            }
        }
        *self.stack_out.last().unwrap()
    }

    fn empty(&self) -> bool {
        self.stack_in.is_empty() && self.stack_out.is_empty()
    }
}