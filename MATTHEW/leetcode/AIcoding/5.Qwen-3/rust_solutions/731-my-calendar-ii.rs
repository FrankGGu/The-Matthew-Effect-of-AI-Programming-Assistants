struct MyCalendar {
    events: Vec<(i32, i32)>,
}

impl MyCalendar {
    fn new() -> Self {
        MyCalendar { events: Vec::new() }
    }

    fn book(&mut self, start: i32, end: i32) -> bool {
        for &(s, e) in &self.events {
            let overlap_start = std::cmp::max(start, s);
            let overlap_end = std::cmp::min(end, e);
            if overlap_start < overlap_end {
                return false;
            }
        }
        self.events.push((start, end));
        true
    }
}