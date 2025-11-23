struct RecentCounter {
    queue: std::collections::VecDeque<i32>,
}

impl RecentCounter {
    fn new() -> Self {
        RecentCounter {
            queue: std::collections::VecDeque::new(),
        }
    }

    fn ping(&mut self, t: i32) -> i32 {
        self.queue.push_back(t);
        while let Some(&front) = self.queue.front() {
            if front < t - 3000 {
                self.queue.pop_front();
            } else {
                break;
            }
        }
        self.queue.len() as i32
    }
}