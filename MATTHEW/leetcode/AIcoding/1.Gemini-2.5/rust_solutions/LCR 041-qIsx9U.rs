use std::collections::VecDeque;

struct MovingAverage {
    size: usize,
    sum: i64,
    queue: VecDeque<i32>,
}

impl MovingAverage {
    fn new(size: i32) -> Self {
        MovingAverage {
            size: size as usize,
            sum: 0,
            queue: VecDeque::new(),
        }
    }

    fn next(&mut self, val: i32) -> f64 {
        self.queue.push_back(val);
        self.sum += val as i64;

        if self.queue.len() > self.size {
            if let Some(old_val) = self.queue.pop_front() {
                self.sum -= old_val as i64;
            }
        }

        self.sum as f64 / self.queue.len() as f64
    }
}