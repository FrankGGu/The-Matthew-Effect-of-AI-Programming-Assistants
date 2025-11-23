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
        for (i, &p) in product.iter().enumerate() {
            let index = self.products.iter().position(|&x| x == p).unwrap();
            total += self.prices[index] as f64 * amount[i] as f64;
        }
        if self.count % self.n == 0 {
            total -= (self.discount as f64 * total) / 100.0;
        }
        total
    }
}