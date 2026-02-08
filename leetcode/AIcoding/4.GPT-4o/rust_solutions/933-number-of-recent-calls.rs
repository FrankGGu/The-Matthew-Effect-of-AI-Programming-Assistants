use std::collections::VecDeque;

struct RecentCounter {
    calls: VecDeque<i32>,
}

impl RecentCounter {
    fn new() -> Self {
        RecentCounter {
            calls: VecDeque::new(),
        }
    }

    fn ping(&mut self, t: i32) -> i32 {
        self.calls.push_back(t);
        while let Some(&time) = self.calls.front() {
            if time < t - 3000 {
                self.calls.pop_front();
            } else {
                break;
            }
        }
        self.calls.len() as i32
    }
}