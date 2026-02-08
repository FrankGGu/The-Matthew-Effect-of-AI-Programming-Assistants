use std::collections::BTreeSet;

struct ExamRoom {
    seats: BTreeSet<usize>,
    n: usize,
}

impl ExamRoom {
    fn new(n: usize) -> Self {
        ExamRoom {
            seats: BTreeSet::new(),
            n,
        }
    }

    fn seat(&mut self) -> usize {
        if self.seats.is_empty() {
            self.seats.insert(0);
            return 0;
        }

        let mut max_dist = 0;
        let mut seat = 0;
        let mut prev = -1;

        for &s in self.seats.iter() {
            let dist = (s as isize - prev - 1) / 2;
            if dist > max_dist {
                max_dist = dist;
                seat = (prev + 1 + dist) as usize;
            }
            prev = s as isize;
        }

        let dist = self.n as isize - 1 - prev;
        if dist > max_dist {
            seat = (self.n - 1) as usize;
        }

        self.seats.insert(seat);
        seat
    }

    fn leave(&mut self, p: usize) {
        self.seats.remove(&p);
    }
}