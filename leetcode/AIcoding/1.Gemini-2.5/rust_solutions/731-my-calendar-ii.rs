struct MyCalendarTwo {
    calendar: Vec<(i32, i32)>,
    overlaps: Vec<(i32, i32)>,
}

impl MyCalendarTwo {
    fn new() -> Self {
        MyCalendarTwo {
            calendar: Vec::new(),
            overlaps: Vec::new(),
        }
    }

    fn book(&mut self, start: i32, end: i32) -> bool {
        for &(os, oe) in &self.overlaps {
            if start < oe && end > os {
                return false;
            }
        }

        for &(cs, ce) in &self.calendar {
            let intersect_start = start.max(cs);
            let intersect_end = end.min(ce);
            if intersect_start < intersect_end {
                self.overlaps.push((intersect_start, intersect_end));
            }
        }

        self.calendar.push((start, end));
        true
    }
}