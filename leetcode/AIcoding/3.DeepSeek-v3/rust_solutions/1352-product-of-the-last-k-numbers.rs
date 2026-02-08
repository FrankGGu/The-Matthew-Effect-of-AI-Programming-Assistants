struct ProductOfNumbers {
    prefix: Vec<i32>,
}

impl ProductOfNumbers {
    fn new() -> Self {
        ProductOfNumbers {
            prefix: vec![1],
        }
    }

    fn add(&mut self, num: i32) {
        if num == 0 {
            self.prefix = vec![1];
        } else {
            let last = *self.prefix.last().unwrap();
            self.prefix.push(last * num);
        }
    }

    fn get_product(&self, k: i32) -> i32 {
        let n = self.prefix.len() as i32;
        if k >= n {
            0
        } else {
            let last = *self.prefix.last().unwrap();
            let prev = self.prefix[(n - k - 1) as usize];
            last / prev
        }
    }
}