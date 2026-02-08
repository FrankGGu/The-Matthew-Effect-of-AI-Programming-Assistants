use std::collections::BTreeSet;

struct SummaryRanges {
    set: BTreeSet<i32>,
}

impl SummaryRanges {
    fn new() -> Self {
        SummaryRanges {
            set: BTreeSet::new(),
        }
    }

    fn add_num(&mut self, value: i32) {
        self.set.insert(value);
    }

    fn get_intervals(&self) -> Vec<Vec<i32>> {
        let mut intervals = Vec::new();
        if self.set.is_empty() {
            return intervals;
        }
        let mut start = *self.set.iter().next().unwrap();
        let mut end = start;
        for &num in self.set.iter().skip(1) {
            if num == end + 1 {
                end = num;
            } else {
                intervals.push(vec![start, end]);
                start = num;
                end = num;
            }
        }
        intervals.push(vec![start, end]);
        intervals
    }
}