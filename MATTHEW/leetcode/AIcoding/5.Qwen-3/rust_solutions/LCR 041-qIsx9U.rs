impl Solution {

use std::collections::VecDeque;

struct MovingAverage {
    capacity: i32,
    queue: VecDeque<i32>,
    sum: i32,
}

impl MovingAverage {
    fn new(size: i32) -> Self {
        MovingAverage {
            capacity: size,
            queue: VecDeque::new(),
            sum: 0,
        }
    }

    fn next(&mut self, val: i32) -> f64 {
        self.sum += val;
        self.queue.push_back(val);

        if self.queue.len() > self.capacity as usize {
            self.sum -= self.queue.pop_front().unwrap();
        }

        self.sum as f64 / self.queue.len() as f64
    }
}

pub fn main() {
    let mut obj = MovingAverage::new(3);
    println!("{}", obj.next(1)); // 1.0
    println!("{}", obj.next(10)); // 5.5
    println!("{}", obj.next(3)); // 4.66667
    println!("{}", obj.next(5)); // 6.0
}
}