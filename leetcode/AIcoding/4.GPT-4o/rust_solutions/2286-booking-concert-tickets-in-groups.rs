use std::collections::HashMap;

struct BookMyShow {
    total_seats: Vec<i32>,
    prefix_sum: Vec<i32>,
}

impl BookMyShow {
    fn new(n: i32, m: i32) -> Self {
        let total_seats = vec![m; n as usize];
        let mut prefix_sum = vec![0; n as usize + 1];
        for i in 1..=n as usize {
            prefix_sum[i] = prefix_sum[i - 1] + total_seats[i - 1];
        }
        BookMyShow { total_seats, prefix_sum }
    }

    fn gather(&mut self, k: i32, max_row: i32) -> Vec<i32> {
        for i in 0..max_row.min(self.total_seats.len() as i32) {
            if self.total_seats[i as usize] >= k {
                self.total_seats[i as usize] -= k;
                return vec![i, self.total_seats[i as usize] + k];
            }
        }
        vec![-1, -1]
    }

    fn scatter(&mut self, k: i32, max_row: i32) -> bool {
        for i in 0..max_row.min(self.total_seats.len() as i32) {
            let available = self.total_seats[i as usize];
            if available >= k {
                self.total_seats[i as usize] -= k;
                return true;
            }
        }
        false
    }
}