struct CustomStack {
    stack: Vec<i32>,
    max_size: usize,
}

impl CustomStack {
    fn new(max_size: i32) -> Self {
        CustomStack {
            stack: Vec::new(),
            max_size: max_size as usize,
        }
    }

    fn push(&mut self, x: i32) {
        if self.stack.len() < self.max_size {
            self.stack.push(x);
        }
    }

    fn pop(&mut self) -> i32 {
        if self.stack.is_empty() {
            return -1;
        }
        self.stack.pop().unwrap()
    }

    fn increment(&mut self, k: i32, val: i32) {
        let k = k as usize;
        let limit = k.min(self.stack.len());
        for i in 0..limit {
            self.stack[i] += val;
        }
    }
}