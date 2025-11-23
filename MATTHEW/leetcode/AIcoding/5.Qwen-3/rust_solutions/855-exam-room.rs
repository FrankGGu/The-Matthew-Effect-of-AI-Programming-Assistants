impl Solution {

use std::collections::BTreeSet;

struct ExamRoom {
    n: i32,
    seats: BTreeSet<i32>,
}

impl ExamRoom {
    fn new(n: i32) -> Self {
        ExamRoom { n, seats: BTreeSet::new() }
    }

    fn seat(&mut self) -> i32 {
        if self.seats.is_empty() {
            self.seats.insert(0);
            return 0;
        }

        let mut max_dist = 0;
        let mut best_seat = 0;

        let seats: Vec<i32> = self.seats.iter().map(|&x| x).collect();

        for i in 0..seats.len() - 1 {
            let left = seats[i];
            let right = seats[i + 1];
            let dist = (right - left) / 2;
            if dist > max_dist {
                max_dist = dist;
                best_seat = left + dist;
            }
        }

        let first = *self.seats.iter().next().unwrap();
        if first > 0 {
            let dist = first;
            if dist > max_dist {
                max_dist = dist;
                best_seat = 0;
            }
        }

        let last = *self.seats.iter().rev().next().unwrap();
        if last < self.n - 1 {
            let dist = self.n - 1 - last;
            if dist > max_dist {
                max_dist = dist;
                best_seat = self.n - 1;
            }
        }

        self.seats.insert(best_seat);
        best_seat
    }

    fn leave(&mut self, p: i32) {
        self.seats.remove(&p);
    }
}
}