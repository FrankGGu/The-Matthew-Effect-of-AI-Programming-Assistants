use std::collections::VecDeque;

struct RecentCounter {
    requests: VecDeque<i32>,
}

impl RecentCounter {
    fn new() -> Self {
        RecentCounter {
            requests: VecDeque::new(),
        }
    }

    fn ping(&mut self, t: i32) -> i32 {
        self.requests.push_back(t);
        while let Some(&front_t) = self.requests.front() {
            if front_t < t - 3000 {
                self.requests.pop_front();
            } else {
                break;
            }
        }
        self.requests.len() as i32
    }
}