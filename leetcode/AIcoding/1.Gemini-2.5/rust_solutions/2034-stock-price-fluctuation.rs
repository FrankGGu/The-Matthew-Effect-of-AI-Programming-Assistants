use std::collections::HashMap;
use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct StockPrice {
    prices: HashMap<i32, i32>,
    max_heap: BinaryHeap<(i32, i32)>, // Stores (price, timestamp) for maximum
    min_heap: BinaryHeap<Reverse<(i32, i32)>>, // Stores (price, timestamp) for minimum
    latest_timestamp: i32,
    latest_price: i32,
}

impl StockPrice {
    fn new() -> Self {
        StockPrice {
            prices: HashMap::new(),
            max_heap: BinaryHeap::new(),
            min_heap: BinaryHeap::new(),
            latest_timestamp: 0, 
            latest_price: 0,     
        }
    }

    fn update(&mut self, timestamp: i32, price: i32) {
        self.prices.insert(timestamp, price);

        self.max_heap.push((price, timestamp));
        self.min_heap.push(Reverse((price, timestamp)));

        self.latest_timestamp = timestamp;
        self.latest_price = price;
    }

    fn current(&self) -> i32 {
        self.latest_price
    }

    fn maximum(&mut self) -> i32 {
        loop {
            let &(price, timestamp) = self.max_heap.peek().unwrap();
            if self.prices.get(&timestamp).unwrap() == &price {
                return price;
            } else {
                self.max_heap.pop();
            }
        }
    }

    fn minimum(&mut self) -> i32 {
        loop {
            let Reverse(&(price, timestamp)) = self.min_heap.peek().unwrap();
            if self.prices.get(&timestamp).unwrap() == &price {
                return price;
            } else {
                self.min_heap.pop();
            }
        }
    }
}