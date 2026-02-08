use std::collections::BinaryHeap;

struct SORTracker {
    added: BinaryHeap<i32>,
    removed: BinaryHeap<i32>,
}

impl SORTracker {
    fn new() -> Self {
        SORTracker {
            added: BinaryHeap::new(),
            removed: BinaryHeap::new(),
        }
    }

    fn add(&mut self, name: i32) {
        self.added.push(name);
        if !self.removed.is_empty() && -self.added.peek().unwrap() > *self.removed.peek().unwrap() {
            let a = -self.added.pop().unwrap();
            let b = self.removed.pop().unwrap();
            self.added.push(-b);
            self.removed.push(a);
        }
    }

    fn get(&mut self) -> i32 {
        let res = -self.added.pop().unwrap();
        self.removed.push(res);
        res
    }
}