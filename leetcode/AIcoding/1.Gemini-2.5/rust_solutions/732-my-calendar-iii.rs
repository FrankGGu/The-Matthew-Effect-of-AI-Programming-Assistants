use std::collections::BTreeMap;

struct MyCalendarThree {
    timeline: BTreeMap<i32, i32>,
}

impl MyCalendarThree {
    fn new() -> Self {
        MyCalendarThree {
            timeline: BTreeMap::new(),
        }
    }

    fn book(&mut self, start: i32, end: i32) -> i32 {
        *self.timeline.entry(start).or_insert(0) += 1;
        *self.timeline.entry(end).or_insert(0) -= 1;

        let mut current_overlap = 0;
        let mut max_overlap = 0;

        for (_time, delta) in &self.timeline {
            current_overlap += delta;
            max_overlap = max_overlap.max(current_overlap);
        }
        max_overlap
    }
}