struct OrderedStream {
    data: Vec<String>,
    ptr: usize,
}

impl OrderedStream {
    fn new(n: i32) -> Self {
        OrderedStream {
            data: vec!["".to_string(); n as usize],
            ptr: 0,
        }
    }

    fn insert(&mut self, idKey: i32, value: String) -> Vec<String> {
        self.data[(idKey - 1) as usize] = value;
        let mut result = Vec::new();
        while self.ptr < self.data.len() && !self.data[self.ptr].is_empty() {
            result.push(self.data[self.ptr].clone());
            self.ptr += 1;
        }
        result
    }
}