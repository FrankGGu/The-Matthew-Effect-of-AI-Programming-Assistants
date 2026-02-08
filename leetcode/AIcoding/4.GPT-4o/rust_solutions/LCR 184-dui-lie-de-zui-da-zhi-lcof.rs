struct Cashier {
    n: i32,
    discount: i32,
    count: i32,
    product_prices: std::collections::HashMap<i32, i32>,
}

impl Cashier {
    fn new(n: i32, discount: i32, products: Vec<i32>, prices: Vec<i32>) -> Self {
        let mut product_prices = std::collections::HashMap::new();
        for i in 0..products.len() {
            product_prices.insert(products[i], prices[i]);
        }
        Cashier { n, discount, count: 0, product_prices }
    }

    fn get_bill(&mut self, cart: Vec<i32>, amounts: Vec<i32>) -> f64 {
        let mut total = 0;
        for (i, product) in cart.iter().enumerate() {
            if let Some(&price) = self.product_prices.get(product) {
                total += price * amounts[i];
            }
        }
        self.count += 1;
        if self.count == self.n {
            total = total * (100 - self.discount) / 100;
            self.count = 0;
        }
        total as f64
    }
}