struct MyHashMap {
    buckets: Vec<Vec<(i32, i32)>>,
}

const NUM_BUCKETS: usize = 2069; 

impl MyHashMap {
    fn new() -> Self {
        MyHashMap {
            buckets: vec![Vec::new(); NUM_BUCKETS],
        }
    }

    fn hash(&self, key: i32) -> usize {
        key as usize % NUM_BUCKETS
    }

    fn put(&mut self, key: i32, value: i32) {
        let bucket_idx = self.hash(key);
        let bucket = &mut self.buckets[bucket_idx];

        for pair in bucket.iter_mut() {
            if pair.0 == key {
                pair.1 = value;
                return;
            }
        }
        bucket.push((key, value));
    }

    fn get(&self, key: i32) -> i32 {
        let bucket_idx = self.hash(key);
        let bucket = &self.buckets[bucket_idx];

        for pair in bucket.iter() {
            if pair.0 == key {
                return pair.1;
            }
        }
        -1
    }

    fn remove(&mut self, key: i32) {
        let bucket_idx = self.hash(key);
        let bucket = &mut self.buckets[bucket_idx];

        let mut found_idx = None;
        for (i, pair) in bucket.iter().enumerate() {
            if pair.0 == key {
                found_idx = Some(i);
                break;
            }
        }

        if let Some(idx) = found_idx {
            bucket.remove(idx);
        }
    }
}