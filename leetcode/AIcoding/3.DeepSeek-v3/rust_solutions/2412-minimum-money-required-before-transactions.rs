impl Solution {
    pub fn minimum_money(transactions: Vec<Vec<i32>>) -> i64 {
        let mut total_loss = 0i64;
        let mut max_cashback = 0i64;
        let mut max_cost = 0i64;

        for t in &transactions {
            let cost = t[0] as i64;
            let cashback = t[1] as i64;
            if cost > cashback {
                total_loss += cost - cashback;
                max_cashback = max_cashback.max(cashback);
            } else {
                max_cost = max_cost.max(cost);
            }
        }

        total_loss + max_cashback.max(max_cost)
    }
}