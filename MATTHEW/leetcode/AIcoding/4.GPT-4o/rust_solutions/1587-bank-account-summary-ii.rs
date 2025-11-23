pub fn account_summary(transactions: Vec<i32>) -> Vec<String> {
    let mut balance = 0;
    let mut deposit = 0;
    let mut withdrawal = 0;

    for &trans in &transactions {
        if trans > 0 {
            deposit += trans;
        } else {
            withdrawal -= trans;
        }
        balance += trans;
    }

    vec![
        format!("Total deposit: {}", deposit),
        format!("Total withdrawal: {}", withdrawal),
        format!("Account balance: {}", balance),
    ]
}