use std::collections::HashMap;

struct Cashier {
    n: i32,
    discount_percentage: i32,
    product_prices: HashMap<i32, i32>,
    order_counter: i32,
}

impl Cashier {
    fn new(n: i32, discount: i32, products: Vec<i32>, prices: Vec<i32>) -> Self {
        let mut product_prices = HashMap::new();
        for i in 0..products.len() {
            product_prices.insert(products[i], prices[i]);
        }
        Cashier {
            n,
            discount_percentage: discount,
            product_prices,
            order_counter: 0,
        }
    }

    fn get_bill(&mut self, product: Vec<i32>, amount: Vec<i32>) -> f64 {
        self.order_counter += 1;
        let mut total_bill: f64 = 0.0;

        for i in 0..product.len() {
            let product_id = product[i];
            let quantity = amount[i];
            let price = *self.product_prices.get(&product_id).unwrap() as f64;
            total_bill += price * quantity as f64;
        }

        if self.order_counter % self.n == 0 {
            total_bill *= (100.0 - self.discount_percentage as f64) / 100.0;
        }

        total_bill
    }
}