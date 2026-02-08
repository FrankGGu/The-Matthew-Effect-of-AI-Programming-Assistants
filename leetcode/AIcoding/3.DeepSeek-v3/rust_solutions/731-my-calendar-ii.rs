use std::collections::BTreeMap;

struct MyCalendarTwo {
    events: BTreeMap<i32, i32>,
}

impl MyCalendarTwo {
    fn new() -> Self {
        MyCalendarTwo {
            events: BTreeMap::new(),
        }
    }

    fn book(&mut self, start: i32, end: i32) -> bool {
        *self.events.entry(start).or_insert(0) += 1;
        *self.events.entry(end).or_insert(0) -= 1;

        let mut active = 0;
        for (_, &delta) in self.events.iter() {
            active += delta;
            if active >= 3 {
                *self.events.entry(start).or_insert(0) -= 1;
                *self.events.entry(end).or_insert(0) += 1;
                return false;
            }
        }
        true
    }
}