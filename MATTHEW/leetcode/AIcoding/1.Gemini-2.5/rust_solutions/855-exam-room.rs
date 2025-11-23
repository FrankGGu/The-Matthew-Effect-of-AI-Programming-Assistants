use std::collections::BTreeSet;

struct ExamRoom {
    n: i32,
    seats: BTreeSet<i32>,
}

impl ExamRoom {
    fn new(n: i32) -> Self {
        ExamRoom {
            n,
            seats: BTreeSet::new(),
        }
    }

    fn seat(&mut self) -> i32 {
        if self.seats.is_empty() {
            self.seats.insert(0);
            return 0;
        }

        let mut max_dist = -1;
        let mut seat_idx = -1;

        // Candidate 1: Position 0
        let first_seat = *self.seats.iter().next().unwrap();
        if first_seat != 0 {
            max_dist = first_seat; // Distance from 0 to first_seat
            seat_idx = 0;
        }

        // Iterate through gaps between seated people
        let mut p1 = first_seat;
        for &p2 in self.seats.iter().skip(1) {
            let current_dist = (p2 - p1) / 2;
            let current_seat = p1 + current_dist;

            if current_dist > max_dist {
                max_dist = current_dist;
                seat_idx = current_seat;
            } else if current_dist == max_dist {
                // Tie-breaking: choose smallest index
                if current_seat < seat_idx {
                    seat_idx = current_seat;
                }
            }
            p1 = p2;
        }

        // Candidate 2: Position n-1
        let last_seat = *self.seats.iter().next_back().unwrap();
        if last_seat != self.n - 1 {
            let dist_to_last = (self.n - 1) - last_seat;
            if dist_to_last > max_dist {
                max_dist = dist_to_last;
                seat_idx = self.n - 1;
            } else if dist_to_last == max_dist {
                // Tie-breaking: choose smallest index
                if (self.n - 1) < seat_idx {
                    seat_idx = self.n - 1;
                }
            }
        }

        self.seats.insert(seat_idx);
        seat_idx
    }

    fn leave(&mut self, p: i32) {
        self.seats.remove(&p);
    }
}