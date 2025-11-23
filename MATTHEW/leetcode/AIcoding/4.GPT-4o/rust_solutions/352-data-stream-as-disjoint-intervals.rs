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
        let mut to_remove = Vec::new();
        let mut new_start = val;
        let mut new_end = val;

        if let Some(&(start, end)) = self.intervals.range(..=val).next_back() {
            if end + 1 >= val {
                new_start = start;
                new_end = end.max(val);
                to_remove.push((start, end));
            }
        }

        if let Some(&(start, end)) = self.intervals.range(val..).next() {
            if start == val + 1 {
                new_end = end;
                to_remove.push((start, end));
            }
        }

        for interval in to_remove {
            self.intervals.remove(&interval);
        }

        self.intervals.insert((new_start, new_end));
    }

    fn get_intervals(&self) -> Vec<Vec<i32>> {
        self.intervals.iter().map(|&(start, end)| vec![start, end]).collect()
    }
}