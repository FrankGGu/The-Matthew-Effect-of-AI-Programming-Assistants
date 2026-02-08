use std::collections::{BTreeMap, HashMap};

struct StockPrice {
    time_to_price: HashMap<i32, i32>,
    price_count: BTreeMap<i32, i32>,
    latest_time: i32,
}

impl StockPrice {
    fn new() -> Self {
        StockPrice {
            time_to_price: HashMap::new(),
            price_count: BTreeMap::new(),
            latest_time: 0,
        }
    }

    fn update(&mut self, timestamp: i32, price: i32) {
        if let Some(&prev_price) = self.time_to_price.get(&timestamp) {
            let count = self.price_count.entry(prev_price).or_default();
            *count -= 1;
            if *count == 0 {
                self.price_count.remove(&prev_price);
            }
        }
        self.time_to_price.insert(timestamp, price);
        *self.price_count.entry(price).or_default() += 1;
        if timestamp > self.latest_time {
            self.latest_time = timestamp;
        }
    }

    fn current(&self) -> i32 {
        *self.time_to_price.get(&self.latest_time).unwrap()
    }

    fn maximum(&self) -> i32 {
        *self.price_count.keys().next_back().unwrap()
    }

    fn minimum(&self) -> i32 {
        *self.price_count.keys().next().unwrap()
    }
}