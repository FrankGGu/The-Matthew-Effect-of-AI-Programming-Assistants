struct ProductOfNumbers {
    products: Vec<i32>,
}

impl ProductOfNumbers {
    fn new() -> Self {
        ProductOfNumbers {
            products: Vec::new(),
        }
    }

    fn add(&mut self, num: i32) {
        if num == 0 {
            self.products.clear();
        } else {
            if self.products.is_empty() {
                self.products.push(1);
            }
            let last_product = *self.products.last().unwrap();
            self.products.push(last_product * num);
        }
    }

    fn get_product(&self, k: i32) -> i32 {
        let k_usize = k as usize;
        let n = self.products.len();
        if k_usize >= n {
            0
        } else {
            self.products[n - 1] / self.products[n - 1 - k_usize]
        }
    }
}