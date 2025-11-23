use std::collections::HashSet;

struct SeatManager {
    available: HashSet<usize>,
    next_seat: usize,
}

impl SeatManager {
    fn new(n: i32) -> Self {
        let available = (1..=n).collect();
        SeatManager {
            available,
            next_seat: 1,
        }
    }

    fn reserve(&mut self) -> i32 {
        if let Some(&seat) = self.available.iter().next() {
            self.available.remove(&seat);
            seat as i32
        } else {
            self.next_seat as i32
        }
    }

    fn unreserve(&mut self, seat_number: i32) {
        self.available.insert(seat_number as usize);
    }
}