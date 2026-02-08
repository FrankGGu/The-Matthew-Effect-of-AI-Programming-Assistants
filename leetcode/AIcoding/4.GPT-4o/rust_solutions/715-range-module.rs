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
        let mut to_remove = Vec::new();
        for (&l, &r) in self.ranges.range(..=right).rev() {
            if r < left {
                break;
            }
            to_remove.push(l);
        }
        for &l in to_remove.iter() {
            self.ranges.remove(&l);
        }
        self.ranges.insert(left.min(to_remove.iter().map(|&l| self.ranges[&l]).min().unwrap_or(right)), right);
    }

    fn query_range(&self, left: i32, right: i32) -> bool {
        match self.ranges.range(..=left).last() {
            Some((&l, &r)) => r >= right && l <= left,
            None => false,
        }
    }

    fn remove_range(&mut self, left: i32, right: i32) {
        let mut to_add = Vec::new();
        for (&l, &r) in self.ranges.range(..=right).rev() {
            if r < left {
                break;
            }
            if l < left {
                to_add.push((l, left));
            }
            if r > right {
                to_add.push((right, r));
            }
            self.ranges.remove(&l);
        }
        for (nl, nr) in to_add {
            self.ranges.insert(nl, nr);
        }
    }
}