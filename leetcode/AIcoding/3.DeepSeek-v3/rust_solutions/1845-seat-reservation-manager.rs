use std::collections::BinaryHeap;
use std::cmp::Reverse;

struct SeatManager {
    available_seats: BinaryHeap<Reverse<i32>>,
}

impl SeatManager {
    fn new(n: i32) -> Self {
        let mut available_seats = BinaryHeap::new();
        for seat in 1..=n {
            available_seats.push(Reverse(seat));
        }
        SeatManager { available_seats }
    }

    fn reserve(&mut self) -> i32 {
        if let Some(Reverse(seat)) = self.available_seats.pop() {
            seat
        } else {
            -1
        }
    }

    fn unreserve(&mut self, seat_number: i32) {
        self.available_seats.push(Reverse(seat_number));
    }
}