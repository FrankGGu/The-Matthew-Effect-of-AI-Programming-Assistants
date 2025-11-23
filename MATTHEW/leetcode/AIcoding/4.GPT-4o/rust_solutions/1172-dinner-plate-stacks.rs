use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct DinnerPlate {
    stacks: Vec<Vec<i32>>,
    capacity: usize,
}

impl DinnerPlate {
    fn new(capacity: usize) -> Self {
        DinnerPlate {
            stacks: Vec::new(),
            capacity,
        }
    }

    fn push(&mut self, val: i32) {
        if self.stacks.is_empty() || self.stacks.last().unwrap().len() == self.capacity {
            self.stacks.push(Vec::new());
        }
        self.stacks.last_mut().unwrap().push(val);
    }

    fn pop(&mut self) -> i32 {
        while !self.stacks.is_empty() && self.stacks.last().unwrap().is_empty() {
            self.stacks.pop();
        }
        if self.stacks.is_empty() {
            return -1;
        }
        self.stacks.last_mut().unwrap().pop().unwrap()
    }

    fn pop_at_stack(&mut self, index: usize) -> i32 {
        if index >= self.stacks.len() || self.stacks[index].is_empty() {
            return -1;
        }
        let value = self.stacks[index].pop().unwrap();
        while !self.stacks.is_empty() && self.stacks.last().unwrap().is_empty() {
            self.stacks.pop();
        }
        value
    }
}