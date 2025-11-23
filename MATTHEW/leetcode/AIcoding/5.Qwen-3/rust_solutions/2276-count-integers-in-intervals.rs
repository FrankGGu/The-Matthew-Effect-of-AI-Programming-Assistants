impl Solution {

use std::cmp::Ordering;
use std::collections::BTreeSet;

struct SummaryRanges {
    intervals: BTreeSet<(i32, i32)>,
}

impl SummaryRanges {
    fn new() -> Self {
        SummaryRanges {
            intervals: BTreeSet::new(),
        }
    }

    fn add_num(&mut self, val: i32) {
        let mut new_intervals = BTreeSet::new();
        let mut added = false;

        for interval in &self.intervals {
            if val < interval.0 - 1 {
                if !added {
                    new_intervals.insert((val, val));
                    added = true;
                }
                new_intervals.insert(*interval);
            } else if val > interval.1 + 1 {
                new_intervals.insert(*interval);
            } else {
                let new_start = std::cmp::min(val, interval.0);
                let new_end = std::cmp::max(val, interval.1);
                if !added {
                    new_intervals.insert((new_start, new_end));
                    added = true;
                }
            }
        }

        if !added {
            new_intervals.insert((val, val));
        }

        self.intervals = new_intervals;
    }

    fn count(&self) -> i32 {
        self.intervals.iter().map(|&(s, e)| e - s + 1).sum()
    }
}

struct Solution;

impl Solution {
    pub fn count_integers_in_intervals() -> i32 {
        let mut summary = SummaryRanges::new();
        summary.add_num(1);
        summary.add_num(3);
        summary.add_num(5);
        summary.add_num(7);
        summary.add_num(9);
        summary.count()
    }
}
}