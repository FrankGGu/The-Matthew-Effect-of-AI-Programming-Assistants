struct ATM {
    banknotes: [i64; 5],
    values: [i64; 5],
}

impl ATM {
    fn new() -> Self {
        ATM {
            banknotes: [0; 5],
            values: [20, 50, 100, 200, 500],
        }
    }

    fn deposit(&mut self, banknotes_count: Vec<i32>) {
        for i in 0..5 {
            self.banknotes[i] += banknotes_count[i] as i64;
        }
    }

    fn withdraw(&mut self, amount: i32) -> Vec<i32> {
        let mut amount_left = amount as i64;
        let mut result = vec![0; 5];

        for i in (0..5).rev() {
            let count = std::cmp::min(amount_left / self.values[i], self.banknotes[i]);
            amount_left -= count * self.values[i];
            result[i] = count as i32;
        }

        if amount_left == 0 {
            for i in 0..5 {
                self.banknotes[i] -= result[i] as i64;
            }
            result
        } else {
            vec![-1]
        }
    }
}