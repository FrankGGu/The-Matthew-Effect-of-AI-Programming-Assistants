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

        let mut max_dist = *self.seats.iter().next().unwrap();
        let mut seat_pos = 0;

        let mut prev = *self.seats.iter().next().unwrap();
        for &curr in self.seats.iter().skip(1) {
            let dist = (curr - prev) / 2;
            if dist > max_dist {
                max_dist = dist;
                seat_pos = prev + dist;
            }
            prev = curr;
        }

        if self.n - 1 - *self.seats.iter().last().unwrap() > max_dist {
            max_dist = self.n - 1 - *self.seats.iter().last().unwrap();
            seat_pos = self.n - 1;
        }

        self.seats.insert(seat_pos);
        seat_pos
    }

    fn leave(&mut self, p: i32) {
        self.seats.remove(&p);
    }
}