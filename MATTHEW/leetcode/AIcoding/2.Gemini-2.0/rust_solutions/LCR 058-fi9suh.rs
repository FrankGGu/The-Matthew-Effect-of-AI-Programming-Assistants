struct MyCalendar {
    bookings: Vec<(i32, i32)>,
}

impl MyCalendar {
    fn new() -> Self {
        MyCalendar { bookings: Vec::new() }
    }

    fn book(&mut self, start: i32, end: i32) -> bool {
        for &(s, e) in &self.bookings {
            if start < e && end > s {
                return false;
            }
        }
        self.bookings.push((start, end));
        true
    }
}