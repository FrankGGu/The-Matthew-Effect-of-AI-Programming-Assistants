struct MyHashMap {
    buckets: Vec<Vec<(i32, i32)>>,
    capacity: usize,
}

impl MyHashMap {
    fn new() -> Self {
        let capacity = 1000;
        MyHashMap {
            buckets: vec![Vec::new(); capacity],
            capacity,
        }
    }

    fn put(&mut self, key: i32, value: i32) {
        let index = self.hash(key);
        let bucket = &mut self.buckets[index];
        for (k, v) in bucket.iter_mut() {
            if *k == key {
                *v = value;
                return;
            }
        }
        bucket.push((key, value));
    }

    fn get(&self, key: i32) -> i32 {
        let index = self.hash(key);
        let bucket = &self.buckets[index];
        for (k, v) in bucket.iter() {
            if *k == key {
                return *v;
            }
        }
        -1
    }

    fn remove(&mut self, key: i32) {
        let index = self.hash(key);
        let bucket = &mut self.buckets[index];
        bucket.retain(|(k, _)| *k != key);
    }

    fn hash(&self, key: i32) -> usize {
        (key as usize) % self.capacity
    }
}