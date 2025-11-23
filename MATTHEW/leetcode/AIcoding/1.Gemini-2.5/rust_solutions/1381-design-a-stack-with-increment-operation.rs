struct CustomStack {
    max_size: usize,
    stack: Vec<i32>,
}

impl CustomStack {
    fn new(max_size: i32) -> Self {
        CustomStack {
            max_size: max_size as usize,
            stack: Vec::new(),
        }
    }

    fn push(&mut self, x: i32) {
        if self.stack.len() < self.max_size {
            self.stack.push(x);
        }
    }

    fn pop(&mut self) -> i32 {
        if let Some(val) = self.stack.pop() {
            val
        } else {
            -1
        }
    }

    fn increment(&mut self, k: i32, val: i32) {
        let limit = k as usize;
        let actual_elements_to_increment = std::cmp::min(limit, self.stack.len());
        for i in 0..actual_elements_to_increment {
            self.stack[i] += val;
        }
    }
}