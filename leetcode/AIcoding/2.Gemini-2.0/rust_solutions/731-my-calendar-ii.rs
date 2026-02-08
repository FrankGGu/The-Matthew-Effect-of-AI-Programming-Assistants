use std::collections::BTreeMap;

struct MyCalendarTwo {
    events: BTreeMap<i32, i32>,
}

impl MyCalendarTwo {
    fn new() -> Self {
        MyCalendarTwo {
            events: BTreeMap::new(),
        }
    }

    fn book(&mut self, start: i32, end: i32) -> bool {
        let mut overlaps = 0;
        let mut current = 0;

        self.events.insert(start, self.events.get(&start).copied().unwrap_or(0) + 1);
        self.events.insert(end, self.events.get(&end).copied().unwrap_or(0) - 1);

        let mut sorted_keys: Vec<_> = self.events.keys().cloned().collect();
        sorted_keys.sort();
        sorted_keys.dedup();

        let mut temp_events: BTreeMap<i32, i32> = BTreeMap::new();

        for &key in &sorted_keys {
            if !self.events.contains_key(&key) {
                continue;
            }
            temp_events.insert(key, *self.events.get(&key).unwrap());
        }

        self.events = temp_events;

        for (&time, &delta) in &self.events {
            current += delta;
            if current > 2 {
                self.events.insert(start, self.events.get(&start).copied().unwrap_or(0) - 1);
                if self.events.get(&start).copied().unwrap_or(0) == 0 {
                    self.events.remove(&start);
                }
                self.events.insert(end, self.events.get(&end).copied().unwrap_or(0) + 1);
                if self.events.get(&end).copied().unwrap_or(0) == 0 {
                    self.events.remove(&end);
                }
                return false;
            }
        }
        true
    }
}