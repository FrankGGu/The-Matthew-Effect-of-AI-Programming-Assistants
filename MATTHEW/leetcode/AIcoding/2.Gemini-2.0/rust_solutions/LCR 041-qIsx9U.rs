struct MovingAverage {
    window_size: i32,
    window: Vec<i32>,
    sum: i64,
}

impl MovingAverage {
    fn new(size: i32) -> Self {
        MovingAverage {
            window_size: size,
            window: Vec::new(),
            sum: 0,
        }
    }

    fn next(&mut self, val: i32) -> f64 {
        self.window.push(val);
        self.sum += val as i64;

        if self.window.len() as i32 > self.window_size {
            self.sum -= self.window.remove(0) as i64;
        }

        self.sum as f64 / self.window.len() as f64
    }
}