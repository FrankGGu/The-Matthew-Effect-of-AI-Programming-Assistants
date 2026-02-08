use std::collections::HashMap;

pub fn bank_account_summary_ii(users_data: Vec<Vec<String>>, transactions_data: Vec<Vec<String>>) -> Vec<Vec<String>> {
    let mut user_names: HashMap<i32, String> = HashMap::new();
    for user_row in users_data {
        let user_id = user_row[0].parse::<i32>().unwrap();
        let user_name = user_row[1].clone();
        user_names.insert(user_id, user_name);
    }

    let mut balances: HashMap<i32, i32> = HashMap::new();
    for transaction_row in transactions_data {
        let account_id = transaction_row[1].parse::<i32>().unwrap();
        let amount = transaction_row[2].parse::<i32>().unwrap();
        *balances.entry(account_id).or_insert(0) += amount;
    }

    let mut result: Vec<Vec<String>> = Vec::new();
    for (user_id, balance) in balances {
        if balance > 10000 {
            if let Some(user_name) = user_names.get(&user_id) {
                result.push(vec![user_name.clone(), balance.to_string()]);
            }
        }
    }

    result
}