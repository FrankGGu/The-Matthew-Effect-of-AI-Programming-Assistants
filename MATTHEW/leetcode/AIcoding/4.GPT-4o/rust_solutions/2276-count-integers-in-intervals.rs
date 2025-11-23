use std::collections::BTreeMap;

struct CountIntervals {
    intervals: BTreeMap<i32, i32>,
}

impl CountIntervals {
    fn new() -> Self {
        CountIntervals {
            intervals: BTreeMap::new(),
        }
    }

    fn add(&mut self, left: i32, right: i32) {
        let mut to_remove = vec![];
        let mut new_left = left;
        let mut new_right = right;

        for (&l, &r) in self.intervals.range(..=right).rev() {
            if r < left {
                break;
            }
            to_remove.push(l);
            new_left = new_left.min(l);
            new_right = new_right.max(r);
        }

        for l in to_remove {
            self.intervals.remove(&l);
        }

        self.intervals.insert(new_left, new_right);
    }

    fn count(&self) -> i32 {
        self.intervals.iter().map(|(&l, &r)| r - l + 1).sum()
    }
}