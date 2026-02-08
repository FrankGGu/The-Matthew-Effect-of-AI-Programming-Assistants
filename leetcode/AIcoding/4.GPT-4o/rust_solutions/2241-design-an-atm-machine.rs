use std::collections::HashMap;

struct ATM {
    banknotes: Vec<i32>,
    counts: Vec<i32>,
}

impl ATM {
    fn new() -> Self {
        ATM {
            banknotes: vec![20, 50, 100, 200, 500],
            counts: vec![0; 5],
        }
    }

    fn deposit(&mut self, banknotes_count: Vec<i32>) {
        for (i, &count) in banknotes_count.iter().enumerate() {
            self.counts[i] += count;
        }
    }

    fn withdraw(&mut self, amount: i32) -> Vec<i32> {
        let mut result = vec![0; 5];
        let mut remaining = amount;

        for i in (0..5).rev() {
            if remaining == 0 {
                break;
            }
            let take = remaining / self.banknotes[i].min(remaining);
            let take = take.min(self.counts[i]);
            result[i] = take;
            remaining -= take * self.banknotes[i];
        }

        if remaining > 0 {
            return vec![-1];
        }

        for i in 0..5 {
            self.counts[i] -= result[i];
        }

        result
    }
}