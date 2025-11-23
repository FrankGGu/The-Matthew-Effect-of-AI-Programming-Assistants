struct MyStack {
    queue: Vec<i32>,
}

impl MyStack {
    fn new() -> Self {
        MyStack { queue: Vec::new() }
    }

    fn push(&mut self, x: i32) {
        self.queue.push(x);
        let len = self.queue.len();
        for _ in 0..len - 1 {
            let front = self.queue.remove(0);
            self.queue.push(front);
        }
    }

    fn pop(&mut self) -> i32 {
        self.queue.remove(0)
    }

    fn top(&self) -> i32 {
        *self.queue.first().unwrap()
    }

    fn empty(&self) -> bool {
        self.queue.is_empty()
    }
}