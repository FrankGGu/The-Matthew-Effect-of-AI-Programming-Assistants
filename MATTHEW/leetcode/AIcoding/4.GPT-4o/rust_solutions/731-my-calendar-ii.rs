use std::collections::HashMap;

struct MyCalendarTwo {
    events: Vec<(i32, i32)>,
    overlaps: HashMap<i32, i32>,
}

impl MyCalendarTwo {
    fn new() -> Self {
        MyCalendarTwo {
            events: Vec::new(),
            overlaps: HashMap::new(),
        }
    }

    fn book(&mut self, start: i32, end: i32) -> bool {
        for &(s, e) in &self.events {
            if start < e && s < end {
                *self.overlaps.entry(s.max(start)).or_insert(0) += 1;
                *self.overlaps.entry(end.min(e)).or_insert(0) -= 1;
            }
        }

        let mut active = 0;
        for time in self.overlaps.keys().cloned().collect::<Vec<_>>().into_iter().collect::<std::collections::BTreeSet<_>>() {
            active += self.overlaps.get(&time).unwrap();
            if active >= 2 {
                for t in self.overlaps.keys() {
                    self.overlaps.insert(*t, 0);
                }
                return false;
            }
        }

        self.events.push((start, end));
        true
    }
}