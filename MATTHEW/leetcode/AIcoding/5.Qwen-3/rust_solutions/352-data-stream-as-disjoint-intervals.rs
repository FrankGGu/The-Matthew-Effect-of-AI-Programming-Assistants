impl Solution {

use std::cmp::Ordering;
use std::collections::BTreeSet;

struct SummaryRanges {
    intervals: BTreeSet<Vec<i32>>,
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
        let mut to_remove = Vec::new();

        for interval in &self.intervals {
            if interval[1] + 1 < val {
                new_intervals.insert(interval.clone());
            } else if interval[0] > val + 1 {
                if !added {
                    new_intervals.insert(vec![val, val]);
                    added = true;
                }
                new_intervals.insert(interval.clone());
            } else {
                to_remove.push(interval.clone());
            }
        }

        if !added {
            new_intervals.insert(vec![val, val]);
        }

        for interval in to_remove {
            self.intervals.remove(&interval);
        }

        for interval in new_intervals {
            self.intervals.insert(interval);
        }
    }

    fn get_summaries(&self) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        for interval in &self.intervals {
            result.push(interval.clone());
        }
        result
    }
}
}