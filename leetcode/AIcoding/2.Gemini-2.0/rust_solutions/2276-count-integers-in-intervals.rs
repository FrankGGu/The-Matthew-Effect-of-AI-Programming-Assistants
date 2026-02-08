use std::collections::BTreeSet;

struct CountIntervals {
    intervals: BTreeSet<(i32, i32)>,
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
        let mut start = left;
        let mut end = right;
        let mut to_remove = Vec::new();

        for &(l, r) in &self.intervals {
            if l > end {
                break;
            }

            if r < start {
                continue;
            }

            start = std::cmp::min(start, l);
            end = std::cmp::max(end, r);
            to_remove.push((l, r));
        }

        for interval in to_remove {
            self.intervals.remove(&interval);
            self.count -= interval.1 - interval.0 + 1;
        }

        self.intervals.insert((start, end));
        self.count += end - start + 1;
    }

    fn count(&self) -> i32 {
        self.count
    }
}