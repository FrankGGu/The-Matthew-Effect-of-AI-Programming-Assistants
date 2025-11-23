pub struct OrderedStream {
    ptr: usize,
    data: Vec<Option<String>>,
}

impl OrderedStream {
    pub fn new(n: usize) -> Self {
        OrderedStream {
            ptr: 0,
            data: vec![None; n],
        }
    }

    pub fn insert(&mut self, id_key: usize, value: String) -> Vec<String> {
        self.data[id_key - 1] = Some(value);
        let mut result = Vec::new();

        while self.ptr < self.data.len() && self.data[self.ptr].is_some() {
            result.push(self.data[self.ptr].as_ref().unwrap().clone());
            self.ptr += 1;
        }

        result
    }
}