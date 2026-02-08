use std::collections::HashMap;
use std::collections::BTreeMap;

struct StockPrice {
    prices: HashMap<i32, i32>,
    timestamps: BTreeMap<i32, i32>,
    latest_timestamp: i32,
}

impl StockPrice {
    fn new() -> Self {
        StockPrice {
            prices: HashMap::new(),
            timestamps: BTreeMap::new(),
            latest_timestamp: 0,
        }
    }

    fn update(&mut self, timestamp: i32, price: i32) {
        if self.prices.contains_key(&timestamp) {
            let old_price = self.prices[&timestamp];
            let mut iter = self.timestamps.iter();
            while let Some((&t, &p)) = iter.next() {
                if t == old_price {
                    if self.timestamps[&old_price] == 1 {
                        self.timestamps.remove(&old_price);
                    } else {
                        self.timestamps.insert(old_price, self.timestamps[&old_price] - 1);
                    }
                    break;
                }
            }
        }

        self.prices.insert(timestamp, price);
        *self.timestamps.entry(price).or_insert(0) += 1;
        self.latest_timestamp = std::cmp::max(self.latest_timestamp, timestamp);
    }

    fn current(&self) -> i32 {
        self.prices[&self.latest_timestamp]
    }

    fn maximum(&self) -> i32 {
        *self.timestamps.keys().last().unwrap()
    }

    fn minimum(&self) -> i32 {
        *self.timestamps.keys().next().unwrap()
    }
}