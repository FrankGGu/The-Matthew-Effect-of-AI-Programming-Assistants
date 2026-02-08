struct ATM {
    counts: Vec<i64>,
    denominations: Vec<i64>,
}

impl ATM {
    fn new() -> Self {
        ATM {
            counts: vec![0; 5],
            denominations: vec![20, 50, 100, 200, 500],
        }
    }

    fn deposit(&mut self, banknotes: Vec<i32>) {
        for i in 0..5 {
            self.counts[i] += banknotes[i] as i64;
        }
    }

    fn withdraw(&mut self, amount: i32) -> Vec<i32> {
        let mut temp_withdrawal_counts: Vec<i64> = vec![0; 5];
        let mut remaining_amount = amount as i64;

        for i in (0..5).rev() {
            let denom = self.denominations[i];
            let available_notes = self.counts[i];

            if remaining_amount == 0 {
                break;
            }

            let notes_needed = remaining_amount / denom;
            let notes_to_take = std::cmp::min(available_notes, notes_needed);

            temp_withdrawal_counts[i] = notes_to_take;
            remaining_amount -= notes_to_take * denom;
        }

        if remaining_amount == 0 {
            for i in 0..5 {
                self.counts[i] -= temp_withdrawal_counts[i];
            }
            temp_withdrawal_counts.iter().map(|&x| x as i32).collect()
        } else {
            vec![-1]
        }
    }
}