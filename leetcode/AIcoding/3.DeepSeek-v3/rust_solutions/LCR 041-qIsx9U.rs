use std::collections::VecDeque;

struct MovingAverage {
    size: usize,
    sum: i32,
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
        if self.queue.len() == self.size {
            let front = self.queue.pop_front().unwrap();
            self.sum -= front;
        }
        self.queue.push_back(val);
        self.sum += val;
        self.sum as f64 / self.queue.len() as f64
    }
}