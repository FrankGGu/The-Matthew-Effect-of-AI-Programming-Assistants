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

        let mut active = 0;
        let mut max_active = 0;
        for &count in self.events.values() {
            active += count;
            max_active = std::cmp::max(max_active, active);
        }

        max_active
    }
}