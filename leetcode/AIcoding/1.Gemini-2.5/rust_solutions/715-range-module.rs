use std::collections::BTreeMap;
use std::cmp::{min, max};

struct RangeModule {
    ranges: BTreeMap<i32, i32>,
}

impl RangeModule {
    fn new() -> Self {
        RangeModule {
            ranges: BTreeMap::new(),
        }
    }

    fn add_range(&mut self, left: i32, right: i32) {
        let mut current_left = left;
        let mut current_right = right;

        let mut keys_to_remove = Vec::new();

        if let Some((&s_prev, &e_prev)) = self.ranges.range(..=left).rev().next() {
            if e_prev >= left {
                current_left = min(current_left, s_prev);
                current_right = max(current_right, e_prev);
                keys_to_remove.push(s_prev);
            }
        }

        let mut iter_keys_to_check = Vec::new();
        for (&s, _) in self.ranges.range(current_left..) {
            if s > current_right {
                break;
            }
            iter_keys_to_check.push(s);
        }

        for s in iter_keys_to_check {
            if let Some(&e) = self.ranges.get(&s) {
                current_right = max(current_right, e);
                keys_to_remove.push(s);
            }
        }

        for key in keys_to_remove {
            self.ranges.remove(&key);
        }

        self.ranges.insert(current_left, current_right);
    }

    fn query_range(&self, left: i332, right: i32) -> bool {
        if let Some((&s, &e)) = self.ranges.range(..=left).rev().next() {
            return e >= right;
        }
        false
    }

    fn remove_range(&mut self, left: i32, right: i32) {
        let mut intervals_to_add = Vec::new();
        let mut keys_to_remove = Vec::new();

        if let Some((&s_prev, &e_prev)) = self.ranges.range(..=left).rev().next() {
            if e_prev > left {
                if s_prev < left {
                    intervals_to_add.push((s_prev, left));
                }
                keys_to_remove.push(s_prev);
            }
        }

        let mut iter_keys_to_check = Vec::new();
        for (&s, _) in self.ranges.range(left..) {
            if s >= right {
                break;
            }
            iter_keys_to_check.push(s);
        }

        for s in iter_keys_to_check {
            if let Some(&e) = self.ranges.get(&s) {
                keys_to_remove.push(s);

                if e > right {
                    intervals_to_add.push((right, e));
                }
            }
        }

        for key in keys_to_remove {
            self.ranges.remove(&key);
        }

        for (s, e) in intervals_to_add {
            self.ranges.insert(s, e);
        }
    }
}