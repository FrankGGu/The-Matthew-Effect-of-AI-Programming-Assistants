use std::collections::BTreeSet;

struct ExamRoom {
    seats: BTreeSet<i32>,
    n: i32,
}

impl ExamRoom {
    fn new(n: i32) -> Self {
        ExamRoom {
            seats: BTreeSet::new(),
            n,
        }
    }

    fn seat(&mut self) -> i32 {
        if self.seats.is_empty() {
            self.seats.insert(0);
            return 0;
        }

        let mut max_dist = 0;
        let mut pos = 0;
        let mut prev = -1;

        for &seat in &self.seats {
            let dist = if prev == -1 {
                seat
            } else {
                (seat - prev) / 2
            };

            if dist > max_dist {
                max_dist = dist;
                pos = if prev == -1 { 0 } else { prev + dist };
            }
            prev = seat;
        }

        if !self.seats.contains(&(self.n - 1)) {
            let dist = self.n - 1 - prev;
            if dist > max_dist {
                pos = self.n - 1;
            }
        }

        self.seats.insert(pos);
        pos
    }

    fn leave(&mut self, p: i32) {
        self.seats.remove(&p);
    }
}