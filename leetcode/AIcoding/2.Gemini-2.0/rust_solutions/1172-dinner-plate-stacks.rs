use std::collections::BTreeSet;

struct DinnerPlates {
    capacity: i32,
    stacks: Vec<Vec<i32>>,
    available: BTreeSet<usize>,
}

impl DinnerPlates {
    fn new(capacity: i32) -> Self {
        DinnerPlates {
            capacity,
            stacks: Vec::new(),
            available: BTreeSet::new(),
        }
    }

    fn push(&mut self, val: i32) {
        if self.available.is_empty() {
            if self.stacks.is_empty() || self.stacks.last().unwrap().len() == self.capacity as usize {
                self.stacks.push(vec![val]);
            } else {
                let last_index = self.stacks.len() - 1;
                self.stacks[last_index].push(val);
            }
        } else {
            let index = *self.available.first().unwrap();
            self.stacks[index].push(val);
            if self.stacks[index].len() == self.capacity as usize {
                self.available.remove(&index);
            }
        }
    }

    fn pop(&mut self) -> i32 {
        while !self.stacks.is_empty() && self.stacks.last().unwrap().is_empty() {
            self.stacks.pop();
        }

        if self.stacks.is_empty() {
            return -1;
        }

        let last_index = self.stacks.len() - 1;
        let val = self.stacks[last_index].pop().unwrap();
        if self.stacks[last_index].is_empty() {
            self.stacks.pop();
        }
        self.available.insert(last_index);
        val
    }

    fn pop_at_stack(&mut self, index: i32) -> i32 {
        if index < 0 || index >= self.stacks.len() as i32 || self.stacks[index as usize].is_empty() {
            return -1;
        }

        let index = index as usize;
        let val = self.stacks[index].pop().unwrap();
        self.available.insert(index);

        while !self.stacks.is_empty() && self.stacks.last().unwrap().is_empty() {
            self.stacks.pop();
        }

        val
    }
}