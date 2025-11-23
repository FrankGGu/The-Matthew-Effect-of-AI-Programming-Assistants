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
        let mut iter = self.events.range(..&start).rev();
        if let Some((&s, &e)) = iter.next() {
            if e > start {
                return false;
            }
        }
        if let Some((&s, &e)) = self.events.range(end..).next() {
            if s < end {
                return false;
            }
        }
        self.events.insert(start, end);
        true
    }
}