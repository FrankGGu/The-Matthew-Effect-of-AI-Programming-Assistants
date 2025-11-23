impl Solution {

use std::collections::VecDeque;

struct DinnerPlates {
    stacks: Vec<VecDeque<i32>>,
    capacity: usize,
    first_non_full: usize,
}

impl DinnerPlates {
    fn new(capacity: i32) -> Self {
        DinnerPlates {
            stacks: Vec::new(),
            capacity: capacity as usize,
            first_non_full: 0,
        }
    }

    fn push(&mut self, val: i32) {
        while self.first_non_full < self.stacks.len() && self.stacks[self.first_non_full].len() == self.capacity {
            self.first_non_full += 1;
        }

        if self.first_non_full >= self.stacks.len() {
            self.stacks.push(VecDeque::new());
        }

        self.stacks[self.first_non_full].push_back(val);
    }

    fn pop(&mut self) -> i32 {
        while self.stacks.len() > 0 && self.stacks.last().unwrap().len() == 0 {
            self.stacks.pop();
        }

        if self.stacks.len() == 0 {
            return -1;
        }

        let last = self.stacks.len() - 1;
        let val = self.stacks[last].pop_back().unwrap();

        if self.stacks[last].len() == 0 {
            self.stacks.pop();
        }

        return val;
    }

    fn pop_at_stack(&mut self, index: i32) -> i32 {
        let index = index as usize;
        if index >= self.stacks.len() || self.stacks[index].len() == 0 {
            return -1;
        }

        let val = self.stacks[index].pop_back().unwrap();

        if self.stacks[index].len() == 0 {
            if index < self.first_non_full {
                self.first_non_full = index;
            }
        }

        return val;
    }
}
}