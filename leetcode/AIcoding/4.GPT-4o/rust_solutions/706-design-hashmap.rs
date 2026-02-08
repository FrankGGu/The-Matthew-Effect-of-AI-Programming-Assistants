struct MyHashMap {
    buckets: Vec<Option<Vec<(i32, i32)>>>,
    size: usize,
}

impl MyHashMap {

    fn new() -> Self {
        MyHashMap {
            buckets: vec![None; 1000],
            size: 1000,
        }
    }

    fn put(&mut self, key: i32, value: i32) {
        let index = (key as usize) % self.size;
        let bucket = self.buckets[index].get_or_insert_with(|| Some(Vec::new()));
        for &mut (k, v) in bucket.iter_mut() {
            if k == key {
                *v = value;
                return;
            }
        }
        bucket.as_mut().unwrap().push((key, value));
    }

    fn get(&self, key: i32) -> i32 {
        let index = (key as usize) % self.size;
        if let Some(bucket) = &self.buckets[index] {
            for &(k, v) in bucket {
                if k == key {
                    return v;
                }
            }
        }
        -1
    }

    fn remove(&mut self, key: i32) {
        let index = (key as usize) % self.size;
        if let Some(bucket) = &mut self.buckets[index] {
            bucket.retain(|&(k, _)| k != key);
        }
    }
}