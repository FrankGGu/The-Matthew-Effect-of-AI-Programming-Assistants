struct DataStream {
    value: i32,
    k: i32,
    consecutive_count: i32,
}

impl DataStream {
    fn new(value: i32, k: i32) -> Self {
        DataStream {
            value,
            k,
            consecutive_count: 0,
        }
    }

    fn consec(&mut self, num: i32) -> bool {
        if num == self.value {
            self.consecutive_count += 1;
        } else {
            self.consecutive_count = 0;
        }
        self.consecutive_count >= self.k
    }
}