use std::collections::HashMap;

struct Cashier {
    n: i32,
    discount: i32,
    products: Vec<i32>,
    prices: Vec<i32>,
    count: i32,
    product_price: HashMap<i32, i32>,
}

impl Cashier {
    fn new(n: i32, discount: i32, products: Vec<i32>, prices: Vec<i32>) -> Self {
        let mut product_price = HashMap::new();
        for i in 0..products.len() {
            product_price.insert(products[i], prices[i]);
        }
        Cashier {
            n,
            discount,
            products,
            prices,
            count: 0,
            product_price,
        }
    }

    fn get_bill(&mut self, product: Vec<i32>, amount: Vec<i32>) -> f64 {
        self.count += 1;
        let mut total: i32 = 0;
        for i in 0..product.len() {
            total += self.product_price.get(&product[i]).unwrap() * amount[i];
        }
        if self.count % self.n == 0 {
            total as f64 * (100 - self.discount) as f64 / 100.0
        } else {
            total as f64
        }
    }
}