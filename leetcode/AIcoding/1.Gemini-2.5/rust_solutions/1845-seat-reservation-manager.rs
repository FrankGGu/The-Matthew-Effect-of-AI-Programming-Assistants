use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct SeatManager {
    available_seats: BinaryHeap<Reverse<i32>>,
}

impl SeatManager {
    fn new(n: i32) -> Self {
        let mut available_seats = BinaryHeap::new();
        for i in 1..=n {
            available_seats.push(Reverse(i));
        }
        SeatManager { available_seats }
    }

    fn reserve(&mut self) -> i32 {
        self.available_seats.pop().unwrap().0
    }

    fn unreserve(&mut self, seat_number: i32) {
        self.available_seats.push(Reverse(seat_number));
    }
}