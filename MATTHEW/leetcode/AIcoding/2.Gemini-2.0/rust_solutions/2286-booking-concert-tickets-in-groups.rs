struct BookMyShow {
    seats: Vec<i32>,
    m: i32,
}

impl BookMyShow {
    fn new(n: i32, m: i32) -> Self {
        BookMyShow {
            seats: vec![m; n as usize],
            m,
        }
    }

    fn gather(&mut self, k: i32, max_row: i32) -> Vec<i32> {
        for i in 0..max_row as usize + 1 {
            if self.seats[i] >= k {
                self.seats[i] -= k;
                return vec![i as i32, self.m - self.seats[i] - k];
            }
        }
        vec![]
    }

    fn scatter(&mut self, k: i32, max_row: i32) -> bool {
        let mut total_seats = 0;
        for i in 0..max_row as usize + 1 {
            total_seats += self.seats[i];
        }
        if total_seats < k {
            return false;
        }

        let mut remaining = k;
        for i in 0..max_row as usize + 1 {
            if self.seats[i] <= remaining {
                remaining -= self.seats[i];
                self.seats[i] = 0;
            } else {
                self.seats[i] -= remaining;
                remaining = 0;
                break;
            }
        }
        true
    }
}