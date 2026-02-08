use std::collections::BTreeMap;

struct MyCalendarThree {
    delta: BTreeMap<i32, i32>,
}

impl MyCalendarThree {
    fn new() -> Self {
        MyCalendarThree {
            delta: BTreeMap::new(),
        }
    }

    fn book(&mut self, start: i32, end: i32) -> i32 {
        *self.delta.entry(start).or_insert(0) += 1;
        *self.delta.entry(end).or_insert(0) -= 1;

        let mut active = 0;
        let mut max_active = 0;
        for &d in self.delta.values() {
            active += d;
            if active > max_active {
                max_active = active;
            }
        }
        max_active
    }
}