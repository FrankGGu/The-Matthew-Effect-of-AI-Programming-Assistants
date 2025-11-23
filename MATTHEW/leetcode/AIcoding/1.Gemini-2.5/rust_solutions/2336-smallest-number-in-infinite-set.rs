use std::collections::BTreeSet;

struct SmallestInfiniteSet {
    next_smallest: i32,
    added_back_nums: BTreeSet<i32>,
}

impl SmallestInfiniteSet {
    fn new() -> Self {
        SmallestInfiniteSet {
            next_smallest: 1,
            added_back_nums: BTreeSet::new(),
        }
    }

    fn pop_smallest(&mut self) -> i32 {
        if let Some(&smallest_in_set) = self.added_back_nums.iter().next() {
            if smallest_in_set < self.next_smallest {
                self.added_back_nums.remove(&smallest_in_set);
                return smallest_in_set;
            }
        }

        let result = self.next_smallest;
        self.next_smallest += 1;
        result
    }

    fn add_back(&mut self, num: i32) {
        if num < self.next_smallest {
            self.added_back_nums.insert(num);
        }
    }
}