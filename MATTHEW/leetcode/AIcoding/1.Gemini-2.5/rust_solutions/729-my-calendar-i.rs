struct MyCalendar {
    events: Vec<(i32, i32)>,
}

impl MyCalendar {
    fn new() -> Self {
        MyCalendar {
            events: Vec::new(),
        }
    }

    fn book(&mut self, start: i32, end: i32) -> bool {
        for &(s, e) in &self.events {
            // Check for overlap:
            // An overlap exists if the new event starts before the existing event ends,
            // AND the existing event starts before the new event ends.
            // [s, e) and [start, end)
            // Overlap condition: start < e && s < end
            if start < e && s < end {
                return false; // Overlap detected, cannot book
            }
        }
        // No overlap found, book the event
        self.events.push((start, end));
        true
    }
}