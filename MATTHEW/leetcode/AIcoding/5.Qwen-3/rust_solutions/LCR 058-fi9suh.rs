impl Solution {

use std::cmp::Ordering;
use std::collections::BTreeSet;

struct MyCalendar {
    events: BTreeSet<(i32, i32)>,
}

impl MyCalendar {
    fn new() -> Self {
        MyCalendar {
            events: BTreeSet::new(),
        }
    }

    fn book(&mut self, start: i32, end: i32) -> bool {
        let new_event = (start, end);
        if let Some((prev_start, prev_end)) = self.events.range(..new_event).next_back() {
            if prev_end > start {
                return false;
            }
        }
        if let Some((next_start, _)) = self.events.range(new_event..).next() {
            if next_start < end {
                return false;
            }
        }
        self.events.insert(new_event);
        true
    }
}
}