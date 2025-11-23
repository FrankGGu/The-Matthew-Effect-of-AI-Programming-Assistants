struct CustomStack {
    stack: Vec<i32>,
    capacity: i32,
}

impl CustomStack {
    fn new(max_size: i32) -> Self {
        CustomStack {
            stack: Vec::new(),
            capacity: max_size,
        }
    }

    fn push(&mut self, x: i32) {
        if self.stack.len() < self.capacity as usize {
            self.stack.push(x);
        }
    }

    fn pop(&mut self) -> i32 {
        self.stack.pop().unwrap_or(0)
    }

    fn increment(&mut self, k: i32, val: i32) {
        let mut count = k;
        for i in 0..self.stack.len() {
            if count <= 0 {
                break;
            }
            self.stack[i] += val;
            count -= 1;
        }
    }
}