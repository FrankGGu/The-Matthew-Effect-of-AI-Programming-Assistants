struct StockSpanner {
    stack: Vec<(i32, i32)>,
}

impl StockSpanner {
    fn new() -> Self {
        StockSpanner {
            stack: Vec::new(),
        }
    }

    fn next(&mut self, price: i32) -> i32 {
        let mut span = 1;
        while let Some(&(p, s)) = self.stack.last() {
            if p <= price {
                span += s;
                self.stack.pop();
            } else {
                break;
            }
        }
        self.stack.push((price, span));
        span
    }
}