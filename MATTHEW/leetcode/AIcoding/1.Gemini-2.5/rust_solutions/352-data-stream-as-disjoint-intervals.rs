use std::collections::BTreeSet;
use std::ops::{Bound, RangeBounds};

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
        // 1. Check if val is already covered by an existing interval.
        // Find the interval (s, e) whose start s is the largest s <= val.
        // The upper bound for range is (val, i32::MAX) inclusive, meaning (s, e) <= (val, i32::MAX).
        // This effectively finds intervals where s <= val.
        if let Some(&(s, e)) = self.intervals.range((Bound::Unbounded, Bound::Included(&(val, i32::MAX)))).next_back() {
            if e >= val {
                return; // val is already in an interval
            }
        }

        let mut new_start = val;
        let mut new_end = val;

        let mut to_remove = Vec::new();

        // 2. Check for merging with a preceding interval (s, e) where e == val - 1.
        // Find the interval (s, e) whose start s is the largest s < val.
        // The upper bound for range is (val, i32::MIN) exclusive, meaning (s, e) < (val, i32::MIN).
        // This effectively finds intervals where s < val.
        if let Some(&(s, e)) = self.intervals.range((Bound::Unbounded, Bound::Excluded(&(val, i32::MIN)))).next_back() {
            if e.checked_add(1) == Some(val) {
                new_start = s;
                to_remove.push((s, e));
            }
        }

        // 3. Check for merging with a succeeding interval (s, e) where s == val + 1.
        // Find the interval (s, e) whose start s is the smallest s >= val.
        // The lower bound for range is (val, i32::MAX) inclusive, meaning (s, e) >= (val, i32::MAX).
        // This effectively finds intervals where s >= val.
        // Since we already checked for coverage, we know s cannot be equal to val.
        // So this effectively finds intervals where s > val.
        if let Some(&(s, e)) = self.intervals.range((Bound::Included(&(val, i32::MAX)), Bound::Unbounded)).next() {
            if s.checked_sub(1) == Some(val) {
                new_end = e;
                to_remove.push((s, e));
            }
        }

        // Remove merged intervals
        for interval in to_remove {
            self.intervals.remove(&interval);
        }

        // Insert the new (merged) interval
        self.intervals.insert((new_start, new_end));
    }

    fn get_intervals(&self) -> Vec<Vec<i32>> {
        self.intervals.iter().map(|&(s, e)| vec![s, e]).collect()
    }
}