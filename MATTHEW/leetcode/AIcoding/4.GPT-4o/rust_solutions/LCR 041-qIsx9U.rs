struct MovingAverage {
    size: usize,
    sum: f64,
    queue: std::collections::VecDeque<f64>,
}

impl MovingAverage {
    fn new(size: usize) -> Self {
        MovingAverage {
            size,
            sum: 0.0,
            queue: std::collections::VecDeque::new(),
        }
    }

    fn next(&mut self, val: i32) -> f64 {
        let val_f64 = val as f64;
        self.queue.push_back(val_f64);
        self.sum += val_f64;

        if self.queue.len() > self.size {
            if let Some(removed) = self.queue.pop_front() {
                self.sum -= removed;
            }
        }

        self.sum / self.queue.len() as f64
    }
}