struct ProductOfNumbers {
    products: Vec<i64>,
}

impl ProductOfNumbers {
    fn new() -> Self {
        ProductOfNumbers { products: vec![1] }
    }

    fn add(&mut self, num: i32) {
        if num == 0 {
            self.products.clear();
            self.products.push(1);
        } else {
            let last_product = *self.products.last().unwrap();
            self.products.push(last_product * num as i64);
        }
    }

    fn get_product(&self, k: i32) -> i32 {
        if k >= self.products.len() as i32 {
            return 0;
        }
        (self.products[self.products.len() - 1] / self.products[self.products.len() - 1 - k as usize]) as i32
    }
}