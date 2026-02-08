use std::collections::HashMap;

struct DataStream {
    value: i32,
    k: i32,
    count: i32,
}

impl DataStream {
    fn new(value: i32, k: i32) -> Self {
        DataStream {
            value,
            k,
            count: 0,
        }
    }

    fn consec(&mut self, num: i32) -> bool {
        if num == self.value {
            self.count += 1;
        } else {
            self.count = 0;
        }
        self.count >= self.k
    }
}