use std::collections::HashMap;

struct ATM {
    banknotes: [i32; 5],
    values: [i32; 5],
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
            self.banknotes[i] += banknotes_count[i];
        }
    }

    fn withdraw(&mut self, amount: i32) -> Vec<i32> {
        let mut remaining = amount;
        let mut result = vec![0; 5];
        let mut temp_banknotes = self.banknotes.clone();

        for i in (0..5).rev() {
            let value = self.values[i];
            let count = std::cmp::min(remaining / value, temp_banknotes[i]);
            remaining -= count * value;
            result[i] = count;
            temp_banknotes[i] -= count;
        }

        if remaining == 0 {
            self.banknotes = temp_banknotes;
            result
        } else {
            vec![-1]
        }
    }
}