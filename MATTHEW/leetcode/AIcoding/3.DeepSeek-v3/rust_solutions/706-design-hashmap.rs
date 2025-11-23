struct MyHashMap {
    buckets: Vec<Vec<(i32, i32)>>,
    size: usize,
}

impl MyHashMap {
    fn new() -> Self {
        let size = 1000;
        let buckets = vec![Vec::new(); size];
        MyHashMap { buckets, size }
    }

    fn put(&mut self, key: i32, value: i32) {
        let index = key as usize % self.size;
        if let Some(pair) = self.buckets[index].iter_mut().find(|&&mut (k, _)| k == key) {
            pair.1 = value;
        } else {
            self.buckets[index].push((key, value));
        }
    }

    fn get(&self, key: i32) -> i32 {
        let index = key as usize % self.size;
        self.buckets[index]
            .iter()
            .find(|&&(k, _)| k == key)
            .map_or(-1, |&(_, v)| v)
    }

    fn remove(&mut self, key: i32) {
        let index = key as usize % self.size;
        if let Some(pos) = self.buckets[index].iter().position(|&(k, _)| k == key) {
            self.buckets[index].remove(pos);
        }
    }
}