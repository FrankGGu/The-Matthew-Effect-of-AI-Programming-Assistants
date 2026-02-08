use std::collections::BTreeMap;

struct MyCalendar {
    events: BTreeMap<i32, i32>,
}

impl MyCalendar {
    fn new() -> Self {
        MyCalendar {
            events: BTreeMap::new(),
        }
    }

    fn book(&mut self, start: i32, end: i32) -> bool {
        if let Some((_, &prev_end)) = self.events.range(..=start).last() {
            if prev_end > start {
                return false;
            }
        }
        if let Some((&next_start, _)) = self.events.range(start..).next() {
            if end > next_start {
                return false;
            }
        }
        self.events.insert(start, end);
        true
    }
}