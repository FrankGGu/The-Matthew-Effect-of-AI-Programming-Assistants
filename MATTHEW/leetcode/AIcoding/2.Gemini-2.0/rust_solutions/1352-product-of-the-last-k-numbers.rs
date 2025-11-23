struct ProductOfNumbers {
    prefix_products: Vec<i32>,
}

impl ProductOfNumbers {
    fn new() -> Self {
        ProductOfNumbers {
            prefix_products: vec![1],
        }
    }

    fn add(&mut self, num: i32) {
        if num == 0 {
            self.prefix_products = vec![1];
        } else {
            let last_product = self.prefix_products.last().unwrap();
            self.prefix_products.push(last_product * num);
        }
    }

    fn get_product(&self, k: i32) -> i32 {
        let k = k as usize;
        let n = self.prefix_products.len();
        if k >= n {
            return 0;
        } else {
            let product_k = self.prefix_products[n - 1];
            let product_nk = self.prefix_products[n - 1 - k];
            return product_k / product_nk;
        }
    }
}