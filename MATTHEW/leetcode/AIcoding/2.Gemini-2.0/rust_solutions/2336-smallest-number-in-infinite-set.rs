use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct SmallestInfiniteSet {
    seen: std::collections::HashSet<i32>,
    heap: BinaryHeap<Reverse<i32>>,
    current: i32,
}

impl SmallestInfiniteSet {
    fn new() -> Self {
        SmallestInfiniteSet {
            seen: std::collections::HashSet::new(),
            heap: BinaryHeap::new(),
            current: 1,
        }
    }

    fn pop_smallest(&mut self) -> i32 {
        if !self.heap.is_empty() {
            let Reverse(val) = self.heap.pop().unwrap();
            self.seen.remove(&val);
            return val;
        } else {
            let val = self.current;
            self.current += 1;
            return val;
        }
    }

    fn add_back(&mut self, num: i32) {
        if num < self.current && !self.seen.contains(&num) {
            self.heap.push(Reverse(num));
            self.seen.insert(num);
        }
    }
}