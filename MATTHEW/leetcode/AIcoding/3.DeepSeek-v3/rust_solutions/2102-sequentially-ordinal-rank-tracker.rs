use std::cmp::Reverse;
use std::collections::BinaryHeap;

struct SORTracker {
    min_heap: BinaryHeap<Reverse<(i32, String)>>,
    max_heap: BinaryHeap<(i32, String)>,
}

impl SORTracker {
    fn new() -> Self {
        SORTracker {
            min_heap: BinaryHeap::new(),
            max_heap: BinaryHeap::new(),
        }
    }

    fn add(&mut self, name: String, score: i32) {
        if self.min_heap.is_empty() || (score, name.clone()) > self.min_heap.peek().unwrap().0 {
            self.min_heap.push(Reverse((score, name)));
            if self.min_heap.len() > self.max_heap.len() + 1 {
                let Reverse(val) = self.min_heap.pop().unwrap();
                self.max_heap.push(val);
            }
        } else {
            self.max_heap.push((score, name));
            if self.max_heap.len() > self.min_heap.len() {
                let val = self.max_heap.pop().unwrap();
                self.min_heap.push(Reverse(val));
            }
        }
    }

    fn get(&mut self) -> String {
        let Reverse((score, name)) = self.min_heap.peek().unwrap().clone();
        let res = name.clone();
        self.max_heap.push((score, name));
        let val = self.min_heap.pop().unwrap().0;
        self.min_heap.push(Reverse(val));
        res
    }
}