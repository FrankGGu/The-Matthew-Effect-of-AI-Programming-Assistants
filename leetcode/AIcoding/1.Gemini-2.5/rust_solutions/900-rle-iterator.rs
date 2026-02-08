struct RLEIterator {
    data: Vec<i32>,
    idx: usize,
    count_remaining: i32,
}

impl RLEIterator {
    fn new(a: Vec<i32>) -> Self {
        let mut rle = RLEIterator {
            data: a,
            idx: 0,
            count_remaining: 0,
        };
        if !rle.data.is_empty() {
            rle.count_remaining = rle.data[0];
        }
        rle
    }

    fn next(&mut self, n: i32) -> i32 {
        let mut n_to_consume = n;

        while self.idx < self.data.len() {
            if n_to_consume <= self.count_remaining {
                self.count_remaining -= n_to_consume;
                return self.data[self.idx + 1];
            } else {
                n_to_consume -= self.count_remaining;
                self.idx += 2;
                if self.idx < self.data.len() {
                    self.count_remaining = self.data[self.idx];
                } else {
                    self.count_remaining = 0;
                }
            }
        }
        -1
    }
}