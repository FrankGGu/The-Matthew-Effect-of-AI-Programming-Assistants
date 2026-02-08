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

    fn add_num(&mut self, value: i32) {
        let mut new_interval = (value, value);

        let mut to_remove = Vec::new();
        for &(start, end) in &self.intervals {
            if value >= start - 1 && value <= end + 1 {
                new_interval.0 = std::cmp::min(new_interval.0, start);
                new_interval.1 = std::cmp::max(new_interval.1, end);
                to_remove.push((start, end));
            }
        }

        for interval in to_remove {
            self.intervals.remove(&interval);
        }

        self.intervals.insert(new_interval);
    }

    fn get_intervals(&self) -> Vec<Vec<i32>> {
        let mut result = Vec::new();
        for &(start, end) in &self.intervals {
            result.push(vec![start, end]);
        }
        result
    }
}