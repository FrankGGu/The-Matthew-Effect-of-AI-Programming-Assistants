struct MyHashSet {
    buckets: Vec<Vec<i32>>,
    capacity: usize,
}

impl MyHashSet {
    fn new() -> Self {
        let capacity = 1000;
        MyHashSet {
            buckets: vec![Vec::new(); capacity],
            capacity,
        }
    }

    fn add(&mut self, key: i32) {
        let index = (key as usize) % self.capacity;
        if !self.contains(key) {
            self.buckets[index].push(key);
        }
    }

    fn remove(&mut self, key: i32) {
        let index = (key as usize) % self.capacity;
        if let Some(pos) = self.buckets[index].iter().position(|&x| x == key) {
            self.buckets[index].remove(pos);
        }
    }

    fn contains(&self, key: i32) -> bool {
        let index = (key as usize) % self.capacity;
        self.buckets[index].contains(&key)
    }
}