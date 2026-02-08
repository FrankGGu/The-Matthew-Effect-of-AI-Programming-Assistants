use std::collections::BTreeMap;

struct MyCalendarThree {
    events: BTreeMap<i32, i32>,
}

impl MyCalendarThree {
    fn new() -> Self {
        MyCalendarThree {
            events: BTreeMap::new(),
        }
    }

    fn book(&mut self, start: i32, end: i32) -> i32 {
        *self.events.entry(start).or_insert(0) += 1;
        *self.events.entry(end).or_insert(0) -= 1;

        let mut max_overlaps = 0;
        let mut current_overlaps = 0;

        for &count in self.events.values() {
            current_overlaps += count;
            if current_overlaps > max_overlaps {
                max_overlaps = current_overlaps;
            }
        }

        max_overlaps
    }
}