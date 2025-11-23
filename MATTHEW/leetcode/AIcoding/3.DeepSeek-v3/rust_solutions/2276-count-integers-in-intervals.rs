use std::collections::BTreeSet;

#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
struct Interval {
    left: i32,
    right: i32,
}

struct CountIntervals {
    intervals: BTreeSet<Interval>,
    count: i32,
}

impl CountIntervals {
    fn new() -> Self {
        CountIntervals {
            intervals: BTreeSet::new(),
            count: 0,
        }
    }

    fn add(&mut self, left: i32, right: i32) {
        let mut new_interval = Interval { left, right };
        let mut to_remove = Vec::new();
        let mut merged_left = left;
        let mut merged_right = right;

        for interval in self.intervals.range(..=Interval { left: right + 1, right: right + 1 }) {
            if interval.right >= left - 1 {
                merged_left = merged_left.min(interval.left);
                merged_right = merged_right.max(interval.right);
                to_remove.push(*interval);
            }
        }

        for interval in to_remove {
            self.intervals.remove(&interval);
            self.count -= interval.right - interval.left + 1;
        }

        self.intervals.insert(Interval { left: merged_left, right: merged_right });
        self.count += merged_right - merged_left + 1;
    }

    fn count(&self) -> i32 {
        self.count
    }
}