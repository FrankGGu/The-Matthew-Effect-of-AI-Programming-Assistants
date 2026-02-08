impl Solution {
    pub fn minimum_money(transactions: Vec<Vec<i32>>) -> i64 {
        let mut loss = 0;
        let mut gain: Vec<i32> = Vec::new();
        for transaction in &transactions {
            let cost = transaction[0];
            let cashback = transaction[1];
            if cost > cashback {
                loss += cost - cashback;
                gain.push(cost);
            } else {
                gain.push(cashback);
            }
        }

        gain.sort_by(|a, b| b.cmp(a));

        if gain.is_empty() {
            return loss as i64;
        }

        (loss + gain[0]) as i64
    }
}