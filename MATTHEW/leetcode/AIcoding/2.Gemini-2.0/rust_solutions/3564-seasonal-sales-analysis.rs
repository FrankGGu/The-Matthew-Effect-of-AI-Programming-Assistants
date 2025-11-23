use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq)]
pub struct Transaction {
    pub transaction_id: i32,
    pub product_id: i32,
    pub amount: i32,
    pub transaction_date: String,
}

fn seasonal_sales(transactions: Vec<Transaction>) -> Vec<(i32, i32)> {
    let mut product_sales: HashMap<i32, i32> = HashMap::new();

    for transaction in transactions {
        let month = transaction.transaction_date[5..7].parse::<i32>().unwrap();
        if month >= 3 && month <= 5 {
            *product_sales.entry(transaction.product_id).or_insert(0) += transaction.amount;
        }
    }

    let mut result: Vec<(i32, i32)> = product_sales.into_iter().collect();
    result.sort_by_key(|&(product_id, _)| product_id);

    result
}