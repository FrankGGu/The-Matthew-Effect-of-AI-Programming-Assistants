use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct SeatManager {
    available: BinaryHeap<Reverse<i32>>,
    last: i32,
}

impl SeatManager {
    fn new(n: i32) -> Self {
        SeatManager {
            available: BinaryHeap::new(),
            last: 0,
        }
    }

    fn reserve(&mut self) -> i32 {
        if let Some(Reverse(seat)) = self.available.pop() {
            return seat;
        } else {
            self.last += 1;
            return self.last;
        }
    }

    fn unreserve(&mut self, seat_number: i32) {
        self.available.push(Reverse(seat_number));
    }
}