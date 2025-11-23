impl Solution {

use std::collections::{HashMap, BTreeSet};

struct StockPrice {
    price_map: HashMap<i32, i32>,
    time_price: HashMap<i32, i32>,
    max_time: i32,
    prices: BTreeSet<i32>,
}

impl StockPrice {
    fn new() -> Self {
        StockPrice {
            price_map: HashMap::new(),
            time_price: HashMap::new(),
            max_time: 0,
            prices: BTreeSet::new(),
        }
    }

    fn update(&mut self, timestamp: i32, price: i32) {
        if let Some(&old_price) = self.time_price.get(&timestamp) {
            self.prices.remove(&old_price);
        }

        self.time_price.insert(timestamp, price);
        self.price_map.insert(price, self.price_map.get(&price).copied().unwrap_or(0) + 1);
        self.prices.insert(price);

        if timestamp > self.max_time {
            self.max_time = timestamp;
        }
    }

    fn current(&self) -> i32 {
        *self.time_price.get(&self.max_time).unwrap()
    }

    fn maximum(&self) -> i32 {
        *self.prices.iter().next_back().unwrap()
    }

    fn minimum(&self) -> i32 {
        *self.prices.iter().next().unwrap()
    }
}
}