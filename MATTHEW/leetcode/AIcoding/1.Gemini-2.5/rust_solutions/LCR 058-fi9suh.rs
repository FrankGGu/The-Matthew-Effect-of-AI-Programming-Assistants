struct MyCalendar {
    bookings: Vec<(i32, i32)>,
}

impl MyCalendar {
    fn new() -> Self {
        MyCalendar {
            bookings: Vec::new(),
        }
    }

    fn book(&mut self, start: i32, end: i32) -> bool {
        for &(exist_start, exist_end) in &self.bookings {
            if start < exist_end && end > exist_start {
                return false;
            }
        }
        self.bookings.push((start, end));
        true
    }
}