struct OrderedStream {
    stream: Vec<Option<String>>,
    ptr: usize,
}

impl OrderedStream {
    fn new(n: i32) -> Self {
        OrderedStream {
            stream: vec![None; n as usize],
            ptr: 1,
        }
    }

    fn insert(&mut self, id_key: i32, value: String) -> Vec<String> {
        self.stream[(id_key - 1) as usize] = Some(value);

        let mut result = Vec::new();

        while self.ptr <= self.stream.len() && self.stream[self.ptr - 1].is_some() {
            result.push(self.stream[self.ptr - 1].take().unwrap());
            self.ptr += 1;
        }

        result
    }
}