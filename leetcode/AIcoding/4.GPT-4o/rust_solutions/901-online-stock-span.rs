struct StockSpanner {
    prices: Vec<i32>,
    spans: Vec<i32>,
}

impl StockSpanner {
    fn new() -> Self {
        StockSpanner {
            prices: Vec::new(),
            spans: Vec::new(),
        }
    }

    fn next(&mut self, price: i32) -> i32 {
        let mut span = 1;
        while !self.prices.is_empty() && *self.prices.last().unwrap() <= price {
            span += self.spans.pop().unwrap();
            self.prices.pop();
        }
        self.prices.push(price);
        self.spans.push(span);
        span
    }
}