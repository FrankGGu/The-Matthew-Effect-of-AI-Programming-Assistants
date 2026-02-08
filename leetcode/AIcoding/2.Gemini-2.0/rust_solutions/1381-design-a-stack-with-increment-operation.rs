struct CustomStack {
    stack: Vec<i32>,
    max_size: i32,
}

impl CustomStack {
    fn new(max_size: i32) -> Self {
        CustomStack {
            stack: Vec::new(),
            max_size,
        }
    }

    fn push(&mut self, x: i32) {
        if self.stack.len() < self.max_size as usize {
            self.stack.push(x);
        }
    }

    fn pop(&mut self) -> i32 {
        self.stack.pop().unwrap_or(-1)
    }

    fn increment(&mut self, k: i32, val: i32) {
        let len = self.stack.len();
        let increment_count = std::cmp::min(k as usize, len);
        for i in 0..increment_count {
            self.stack[i] += val;
        }
    }
}