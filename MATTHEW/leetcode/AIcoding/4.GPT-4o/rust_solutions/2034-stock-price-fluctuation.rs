use std::collections::HashMap;
use std::collections::BTreeMap;

struct StockPrice {
    prices: HashMap<i32, i32>,
    times: BTreeMap<i32, i32>,
    latest_time: i32,
}

impl StockPrice {
    fn new() -> Self {
        StockPrice {
            prices: HashMap::new(),
            times: BTreeMap::new(),
            latest_time: 0,
        }
    }

    fn update(&mut self, timestamp: i32, price: i32) {
        if let Some(&old_price) = self.prices.get(&timestamp) {
            self.times.remove(&old_price);
        }
        self.prices.insert(timestamp, price);
        self.times.insert(price, timestamp);
        self.latest_time = self.latest_time.max(timestamp);
    }

    fn current(&self) -> i32 {
        *self.prices.get(&self.latest_time).unwrap()
    }

    fn maximum(&self) -> i32 {
        *self.times.iter().next_back().unwrap().0
    }

    fn minimum(&self) -> i32 {
        *self.times.iter().next().unwrap().0
    }
}