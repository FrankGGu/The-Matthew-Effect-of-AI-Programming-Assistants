use std::collections::BTreeSet;

struct DinnerPlates {
    capacity: usize,
    stacks: Vec<Vec<i32>>,
    available_stacks: BTreeSet<usize>,
    non_empty_stacks: BTreeSet<usize>,
}

impl DinnerPlates {
    fn new(capacity: i32) -> Self {
        DinnerPlates {
            capacity: capacity as usize,
            stacks: Vec::new(),
            available_stacks: BTreeSet::new(),
            non_empty_stacks: BTreeSet::new(),
        }
    }

    fn push(&mut self, val: i32) {
        if self.available_stacks.is_empty() {
            self.stacks.push(Vec::with_capacity(self.capacity));
            let new_stack_idx = self.stacks.len() - 1;
            self.available_stacks.insert(new_stack_idx);
        }

        let stack_idx = *self.available_stacks.iter().next().unwrap();

        self.stacks[stack_idx].push(val);

        self.non_empty_stacks.insert(stack_idx);

        if self.stacks[stack_idx].len() == self.capacity {
            self.available_stacks.remove(&stack_idx);
        }
    }

    fn pop(&mut self) -> i32 {
        if self.non_empty_stacks.is_empty() {
            return -1;
        }

        let stack_idx = *self.non_empty_stacks.iter().rev().next().unwrap();

        let was_full = self.stacks[stack_idx].len() == self.capacity;

        let val = self.stacks[stack_idx].pop().unwrap();

        if was_full {
            self.available_stacks.insert(stack_idx);
        }

        if self.stacks[stack_idx].is_empty() {
            self.non_empty_stacks.remove(&stack_idx);
        }

        val
    }

    fn popAtStack(&mut self, index: i32) -> i32 {
        let idx = index as usize;

        if idx >= self.stacks.len() || self.stacks[idx].is_empty() {
            return -1;
        }

        let was_full = self.stacks[idx].len() == self.capacity;

        let val = self.stacks[idx].pop().unwrap();

        if was_full {
            self.available_stacks.insert(idx);
        }

        if self.stacks[idx].is_empty() {
            self.non_empty_stacks.remove(&idx);
        }

        val
    }
}