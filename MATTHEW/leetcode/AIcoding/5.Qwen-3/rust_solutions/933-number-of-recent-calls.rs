impl Solution {

use std::collections::VecDeque;

struct RecentCalls {
    queue: VecDeque<i32>,
}

impl RecentCalls {
    fn new() -> Self {
        RecentCalls {
            queue: VecDeque::new(),
        }
    }

    fn ping(&mut self, t: i32) -> i32 {
        self.queue.push_back(t);
        while let Some(&oldest) = self.queue.front() {
            if oldest < t - 3000 {
                self.queue.pop_front();
            } else {
                break;
            }
        }
        self.queue.len() as i32
    }
}

struct Solution;

impl Solution {
    pub fn ping(t: i32) -> i32 {
        static mut CALLS: Option<RecentCalls> = None;
        unsafe {
            if CALLS.is_none() {
                CALLS = Some(RecentCalls::new());
            }
            CALLS.as_mut().unwrap().ping(t)
        }
    }
}
}