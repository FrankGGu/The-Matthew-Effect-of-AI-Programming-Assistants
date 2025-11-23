struct OrderedStream {
    ptr: usize,
    data: Vec<Option<String>>,
}

impl OrderedStream {
    fn new(n: i32) -> Self {
        OrderedStream {
            ptr: 0,
            data: vec![None; n as usize],
        }
    }

    fn insert(&mut self, id_key: i32, value: String) -> Vec<String> {
        let idx = (id_key - 1) as usize;
        self.data[idx] = Some(value);
        let mut res = Vec::new();
        while self.ptr < self.data.len() && self.data[self.ptr].is_some() {
            res.push(self.data[self.ptr].take().unwrap());
            self.ptr += 1;
        }
        res
    }
}