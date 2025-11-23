impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct SeatManager {
    available: BinaryHeap<Reverse<i32>>,
}

impl SeatManager {
    fn new(n: i32) -> Self {
        let mut available = BinaryHeap::new();
        for i in 1..=n {
            available.push(Reverse(i));
        }
        SeatManager { available }
    }

    fn reserve(&mut self) -> i32 {
        let Reverse(seat) = self.available.pop().unwrap();
        seat
    }

    fn unreserve(&mut self, seat: i32) {
        self.available.push(Reverse(seat));
    }
}
}