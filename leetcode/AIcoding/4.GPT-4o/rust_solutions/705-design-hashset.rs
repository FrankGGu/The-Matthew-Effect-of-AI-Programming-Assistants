struct MyHashSet {
    buckets: Vec<Vec<i32>>,
    size: usize,
}

impl MyHashSet {
    fn new() -> Self {
        MyHashSet {
            buckets: vec![Vec::new(); 1000],
            size: 1000,
        }
    }

    fn add(&mut self, key: i32) {
        let index = (key % self.size as i32).abs() as usize;
        if !self.buckets[index].contains(&key) {
            self.buckets[index].push(key);
        }
    }

    fn remove(&mut self, key: i32) {
        let index = (key % self.size as i32).abs() as usize;
        if let Some(pos) = self.buckets[index].iter().position(|&x| x == key) {
            self.buckets[index].remove(pos);
        }
    }

    fn contains(&self, key: i32) -> bool {
        let index = (key % self.size as i32).abs() as usize;
        self.buckets[index].contains(&key)
    }
}