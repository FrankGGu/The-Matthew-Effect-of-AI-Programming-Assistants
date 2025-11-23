use std::collections::HashSet;

struct SmallestInfiniteSet {
    next_smallest: usize,
    removed: HashSet<usize>,
}

impl SmallestInfiniteSet {
    fn new() -> Self {
        Self {
            next_smallest: 1,
            removed: HashSet::new(),
        }
    }

    fn pop_smallest(&mut self) -> i32 {
        while self.removed.contains(&self.next_smallest) {
            self.next_smallest += 1;
        }
        let smallest = self.next_smallest;
        self.next_smallest += 1;
        smallest as i32
    }

    fn add_back(&mut self, num: i32) {
        let num = num as usize;
        if num < self.next_smallest {
            self.removed.insert(num);
        }
    }
}