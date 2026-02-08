use std::collections::BTreeSet;

struct RangeModule {
    ranges: BTreeSet<(i32, i32)>,
}

impl RangeModule {
    fn new() -> Self {
        RangeModule {
            ranges: BTreeSet::new(),
        }
    }

    fn add_range(&mut self, left: i32, right: i32) {
        let mut start = left;
        let mut end = right;

        let mut to_remove = Vec::new();

        for &(s, e) in &self.ranges {
            if s > end {
                break;
            }
            if e < start {
                continue;
            }

            start = start.min(s);
            end = end.max(e);
            to_remove.push((s, e));
        }

        for range in to_remove {
            self.ranges.remove(&range);
        }

        self.ranges.insert((start, end));
    }

    fn query_range(&self, left: i32, right: i32) -> bool {
        for &(s, e) in &self.ranges {
            if s <= left && right <= e {
                return true;
            }
        }
        false
    }

    fn remove_range(&mut self, left: i32, right: i32) {
        let mut to_add = Vec::new();
        let mut to_remove = Vec::new();

        for &(s, e) in &self.ranges {
            if s > right {
                break;
            }
            if e < left {
                continue;
            }

            to_remove.push((s, e));

            if s < left {
                to_add.push((s, left));
            }
            if right < e {
                to_add.push((right, e));
            }
        }

        for range in to_remove {
            self.ranges.remove(&range);
        }

        for range in to_add {
            self.ranges.insert(range);
        }
    }
}