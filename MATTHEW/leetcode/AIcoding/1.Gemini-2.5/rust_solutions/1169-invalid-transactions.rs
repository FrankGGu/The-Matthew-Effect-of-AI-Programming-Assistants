struct TransactionData {
    name: String,
    time: i32,
    amount: i32,
    city: String,
    original_idx: usize,
}

impl TransactionData {
    fn from_str_and_idx(s: &str, idx: usize) -> Option<Self> {
        let parts: Vec<&str> = s.split(',').collect();
        if parts.len() == 4 {
            let name = parts[0].to_string();
            let time = parts[1].parse::<i32>().ok()?;
            let amount = parts[2].parse::<i32>().ok()?;
            let city = parts[3].to_string();
            Some(TransactionData { name, time, amount, city, original_idx: idx })
        } else {
            None
        }
    }
}

impl Solution {
    pub fn invalid_transactions(transactions: Vec<String>) -> Vec<String> {
        let n = transactions.len();
        let mut parsed_transactions: Vec<TransactionData> = Vec::with_capacity(n);
        let mut is_invalid: Vec<bool> = vec![false; n];

        for (i, tx_str) in transactions.iter().enumerate() {
            if let Some(tx_data) = TransactionData::from_str_and_idx(tx_str, i) {
                if tx_data.amount > 1000 {
                    is_invalid[i] = true;
                }
                parsed_transactions.push(tx_data);
            }
        }

        let num_parsed = parsed_transactions.len();
        for i in 0..num_parsed {
            for j in (i + 1)..num_parsed {
                let t1 = &parsed_transactions[i];
                let t2 = &parsed_transactions[j];

                if t1.name == t2.name && t1.city != t2.city && (t1.time - t2.time).abs() <= 60 {
                    is_invalid[t1.original_idx] = true;
                    is_invalid[t2.original_idx] = true;
                }
            }
        }

        let mut result: Vec<String> = Vec::new();
        for i in 0..n {
            if is_invalid[i] {
                result.push(transactions[i].clone());
            }
        }

        result
    }
}