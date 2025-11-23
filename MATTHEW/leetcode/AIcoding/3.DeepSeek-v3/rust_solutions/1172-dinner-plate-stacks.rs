use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct DinnerPlates {
    capacity: usize,
    stacks: Vec<Vec<i32>>,
    available: BinaryHeap<Reverse<usize>>,
}

impl DinnerPlates {
    fn new(capacity: i32) -> Self {
        DinnerPlates {
            capacity: capacity as usize,
            stacks: Vec::new(),
            available: BinaryHeap::new(),
        }
    }

    fn push(&mut self, val: i32) {
        while let Some(Reverse(index)) = self.available.peek() {
            if *index < self.stacks.len() && self.stacks[*index].len() < self.capacity {
                let index = *index;
                self.stacks[index].push(val);
                if self.stacks[index].len() == self.capacity {
                    self.available.pop();
                }
                return;
            } else {
                self.available.pop();
            }
        }
        if self.stacks.is_empty() || self.stacks.last().unwrap().len() == self.capacity {
            self.stacks.push(Vec::with_capacity(self.capacity));
        }
        let last_index = self.stacks.len() - 1;
        self.stacks[last_index].push(val);
    }

    fn pop(&mut self) -> i32 {
        while let Some(stack) = self.stacks.last_mut() {
            if stack.is_empty() {
                self.stacks.pop();
            } else {
                return stack.pop().unwrap();
            }
        }
        -1
    }

    fn pop_at_stack(&mut self, index: i32) -> i32 {
        let index = index as usize;
        if index >= self.stacks.len() {
            return -1;
        }
        if let Some(val) = self.stacks[index].pop() {
            self.available.push(Reverse(index));
            val
        } else {
            -1
        }
    }
}