struct Cashier {
    n: i32,
    discount: i32,
    products: Vec<i32>,
    prices: Vec<i32>,
    count: i32,
}

impl Cashier {
    fn new(n: i32, discount: i32, products: Vec<i32>, prices: Vec<i32>) -> Self {
        Cashier {
            n,
            discount,
            products,
            prices,
            count: 0,
        }
    }

    fn get_bill(&mut self, product: Vec<i32>, amount: Vec<i32>) -> f64 {
        self.count += 1;
        let mut total = 0.0;
        for i in 0..product.len() {
            let product_id = product[i];
            let quantity = amount[i];
            let index = self.products.iter().position(|&x| x == product_id).unwrap();
            total += self.prices[index] as f64 * quantity as f64;
        }

        if self.count % self.n == 0 {
            total *= (100 - self.discount) as f64 / 100.0;
        }

        total
    }
}