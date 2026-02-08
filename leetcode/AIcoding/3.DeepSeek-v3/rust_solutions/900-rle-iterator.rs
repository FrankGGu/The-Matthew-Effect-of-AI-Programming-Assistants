struct RLEIterator {
    encoding: Vec<i32>,
    index: usize,
    count: i32,
}

impl RLEIterator {
    fn new(encoding: Vec<i32>) -> Self {
        RLEIterator {
            encoding,
            index: 0,
            count: 0,
        }
    }

    fn next(&mut self, n: i32) -> i32 {
        let mut remaining = n;
        while self.index < self.encoding.len() {
            if self.count + remaining > self.encoding[self.index] {
                remaining -= self.encoding[self.index] - self.count;
                self.count = 0;
                self.index += 2;
            } else {
                self.count += remaining;
                return self.encoding[self.index + 1];
            }
        }
        -1
    }
}