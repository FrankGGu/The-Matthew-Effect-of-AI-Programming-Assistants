struct MyCalendar {
    events: Vec<(i32, i32)>,
}

impl MyCalendar {
    fn new() -> Self {
        MyCalendar { events: Vec::new() }
    }

    fn book(&mut self, start: i32, end: i32) -> bool {
        for &(s, e) in &self.events {
            if start < e && end > s {
                return false;
            }
        }
        self.events.push((start, end));
        true
    }
}