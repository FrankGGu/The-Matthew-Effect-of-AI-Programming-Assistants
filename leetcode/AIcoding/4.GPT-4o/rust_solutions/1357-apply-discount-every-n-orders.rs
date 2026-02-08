pub struct Cashier {
    n: i32,
    discount: i32,
    count: i32,
    price: i32,
}

impl Cashier {
    pub fn new(n: i32, discount: i32, products: Vec<i32>, prices: Vec<i32>) -> Self {
        Cashier {
            n,
            discount,
            count: 0,
            price: 0,
        }
    }

    pub fn get_money_amount(&mut self, product: i32, amount: i32) -> f64 {
        self.count += 1;
        let total = (self.price as f64 + (amount as f64 * product as f64));
        if self.count == self.n {
            self.count = 0;
            return total * (1.0 - self.discount as f64 / 100.0);
        }
        total
    }
}