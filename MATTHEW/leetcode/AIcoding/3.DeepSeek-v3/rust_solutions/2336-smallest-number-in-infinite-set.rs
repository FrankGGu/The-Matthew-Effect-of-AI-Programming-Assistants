use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct SmallestInfiniteSet {
    heap: BinaryHeap<Reverse<i32>>,
    next: i32,
    present: std::collections::HashSet<i32>,
}

impl SmallestInfiniteSet {
    fn new() -> Self {
        SmallestInfiniteSet {
            heap: BinaryHeap::new(),
            next: 1,
            present: std::collections::HashSet::new(),
        }
    }

    fn pop_smallest(&mut self) -> i32 {
        if let Some(Reverse(num)) = self.heap.pop() {
            self.present.remove(&num);
            num
        } else {
            let res = self.next;
            self.next += 1;
            res
        }
    }

    fn add_back(&mut self, num: i32) {
        if num < self.next && !self.present.contains(&num) {
            self.present.insert(num);
            self.heap.push(Reverse(num));
        }
    }
}