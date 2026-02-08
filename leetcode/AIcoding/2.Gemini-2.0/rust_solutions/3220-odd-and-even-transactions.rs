use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq, Hash)]
struct Transaction {
    id: i32,
    customer_id: i32,
    amount: i32,
    transaction_date: String,
}

fn odd_and_even_transactions(transactions: Vec<Transaction>) -> Vec<i32> {
    let mut customer_transactions: HashMap<i32, Vec<Transaction>> = HashMap::new();

    for transaction in transactions {
        customer_transactions
            .entry(transaction.customer_id)
            .or_insert(Vec::new())
            .push(transaction);
    }

    let mut result: Vec<i32> = Vec::new();

    for (customer_id, transactions) in customer_transactions.iter() {
        if transactions.len() % 2 == 0 {
            let mut total_amount: i32 = 0;
            for transaction in transactions {
                total_amount += transaction.amount;
            }
            if total_amount > 0 {
                result.push(*customer_id);
            }
        }
    }

    result.sort();
    result
}