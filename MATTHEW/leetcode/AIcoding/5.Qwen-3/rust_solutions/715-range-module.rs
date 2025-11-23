impl Solution {

use std::collections::BTreeSet;

struct RangeModule {
    intervals: BTreeSet<(i32, i32)>,
}

impl RangeModule {
    fn new() -> Self {
        RangeModule {
            intervals: BTreeSet::new(),
        }
    }

    fn add_range(&mut self, left: i32, right: i32) {
        let mut new_intervals = BTreeSet::new();
        let mut to_add = (left, right);

        for interval in &self.intervals {
            if interval.1 < to_add.0 {
                new_intervals.insert(*interval);
            } else if interval.0 > to_add.1 {
                new_intervals.insert(*interval);
            } else {
                to_add.0 = to_add.0.min(interval.0);
                to_add.1 = to_add.1.max(interval.1);
            }
        }

        new_intervals.insert(to_add);
        self.intervals = new_intervals;
    }

    fn query_ranges(&self, left: i32, right: i32) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        for interval in &self.intervals {
            if interval.1 < left || interval.0 > right {
                continue;
            }
            result.push(vec![interval.0, interval.1]);
        }
        result
    }

    fn remove_range(&mut self, left: i32, right: i32) {
        let mut new_intervals = BTreeSet::new();

        for interval in &self.intervals {
            if interval.1 < left || interval.0 > right {
                new_intervals.insert(*interval);
            } else {
                if interval.0 < left {
                    new_intervals.insert((interval.0, left - 1));
                }
                if interval.1 > right {
                    new_intervals.insert((right + 1, interval.1));
                }
            }
        }

        self.intervals = new_intervals;
    }
}
}