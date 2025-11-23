use std::collections::BTreeMap;

struct RangeModule {
    ranges: BTreeMap<i32, i32>,
}

impl RangeModule {
    fn new() -> Self {
        RangeModule {
            ranges: BTreeMap::new(),
        }
    }

    fn add_range(&mut self, left: i32, right: i32) {
        if left >= right {
            return;
        }
        let mut start = left;
        let mut end = right;
        let mut to_remove = vec![];

        if let Some((&s, &e)) = self.ranges.range(..=left).next_back() {
            if e >= left {
                start = s;
                end = end.max(e);
                to_remove.push(s);
            }
        }

        for (&s, &e) in self.ranges.range(left..=right) {
            end = end.max(e);
            to_remove.push(s);
        }

        for s in to_remove {
            self.ranges.remove(&s);
        }

        self.ranges.insert(start, end);
    }

    fn query_range(&self, left: i32, right: i32) -> bool {
        if left >= right {
            return false;
        }
        if let Some((&s, &e)) = self.ranges.range(..=left).next_back() {
            if s <= left && e >= right {
                return true;
            }
        }
        false
    }

    fn remove_range(&mut self, left: i32, right: i32) {
        if left >= right {
            return;
        }
        let mut to_remove = vec![];
        let mut to_add = vec![];

        if let Some((&s, &e)) = self.ranges.range(..=left).next_back() {
            if e > left {
                to_remove.push(s);
                if s < left {
                    to_add.push((s, left));
                }
                if e > right {
                    to_add.push((right, e));
                }
            }
        }

        for (&s, &e) in self.ranges.range(left..right) {
            to_remove.push(s);
            if e > right {
                to_add.push((right, e));
            }
        }

        for s in to_remove {
            self.ranges.remove(&s);
        }
        for (s, e) in to_add {
            self.ranges.insert(s, e);
        }
    }
}