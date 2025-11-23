impl Solution {

use std::collections::{BinaryHeap, HashMap};

struct MKAverage {
    m: i32,
    k: i32,
    data: Vec<i32>,
    total: i64,
    count: i32,
    min_heap: BinaryHeap<i32>,
    max_heap: BinaryHeap<i32>,
    mid_heap: BinaryHeap<i32>,
    size: i32,
}

impl MKAverage {
    fn new(m: i32, k: i32) -> Self {
        MKAverage {
            m,
            k,
            data: vec![],
            total: 0,
            count: 0,
            min_heap: BinaryHeap::new(),
            max_heap: BinaryHeap::new(),
            mid_heap: BinaryHeap::new(),
            size: 0,
        }
    }

    fn add(self: &mut Self, num: i32) {
        self.data.push(num);
        self.total += num as i64;
        self.count += 1;
        self.size += 1;

        if self.size > self.m {
            let removed = self.data[self.size as usize - self.m as usize - 1];
            self.total -= removed as i64;
        }

        if self.size >= self.m {
            let mut temp = self.data.clone();
            temp.sort();
            let mut sum = 0;
            for i in (self.k as usize)..(self.m as usize - self.k as usize) {
                sum += temp[i];
            }
            self.total = sum as i64;
        }
    }

    fn calculate(self: &Self) -> i32 {
        if self.size < self.m {
            return -1;
        }
        self.total as i32
    }
}
}