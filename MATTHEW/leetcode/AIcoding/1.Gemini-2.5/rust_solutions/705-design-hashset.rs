struct MyHashSet {
    data: Vec<bool>,
}

impl MyHashSet {
    fn new() -> Self {
        MyHashSet {
            data: vec![false; 1_000_001],
        }
    }

    fn add(&mut self, key: i32) {
        self.data[key as usize] = true;
    }

    fn remove(&mut self, key: i32) {
        self.data[key as usize] = false;
    }

    fn contains(&self, key: i32) -> bool {
        self.data[key as usize]
    }
}