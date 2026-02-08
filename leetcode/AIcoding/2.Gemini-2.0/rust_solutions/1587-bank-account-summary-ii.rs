use std::collections::HashMap;

impl Solution {
    pub fn bank_account_summary(transactions: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut balances: HashMap<i32, i64> = HashMap::new();
        for transaction in transactions {
            let account_id = transaction[0];
            let amount = transaction[1] as i64;
            *balances.entry(account_id).or_insert(0) += amount;
        }

        let mut result: Vec<Vec<i32>> = balances
            .into_iter()
            .filter(|(_, balance)| *balance > 10000)
            .map(|(account_id, balance)| vec![account_id, balance as i32])
            .collect();

        result.sort_by(|a, b| a[0].cmp(&b[0]));
        result
    }
}