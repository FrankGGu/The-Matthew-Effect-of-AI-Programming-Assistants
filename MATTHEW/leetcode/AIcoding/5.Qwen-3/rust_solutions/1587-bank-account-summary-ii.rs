impl Solution {

use std::collections::HashMap;

#[derive(Debug, PartialEq, Eq)]
struct Account {
    account: i32,
    name: String,
}

#[derive(Debug, PartialEq, Eq)]
struct Transactions {
    account: i32,
    amount: i32,
}

fn main() {
    let accounts = vec![
        Account {
            account: 907,
            name: "Alice".to_string(),
        },
        Account {
            account: 112,
            name: "Bob".to_string(),
        },
    ];
    let transactions = vec![
        Transactions {
            account: 907,
            amount: 1000,
        },
        Transactions {
            account: 112,
            amount: -500,
        },
        Transactions {
            account: 112,
            amount: 1000,
        },
    ];
    let result = account_summary(accounts, transactions);
    for row in result {
        println!("{:?}, {:?}", row.0, row.1);
    }
}

fn account_summary(
    accounts: Vec<Account>,
    transactions: Vec<Transactions>,
) -> Vec<(i32, String)> {
    let mut balance_map: HashMap<i32, i32> = HashMap::new();
    for transaction in transactions {
        *balance_map.entry(transaction.account).or_insert(0) += transaction.amount;
    }

    let mut result = Vec::new();
    for account in accounts {
        if let Some(&balance) = balance_map.get(&account.account) {
            result.push((account.account, account.name));
        }
    }

    result
}
}