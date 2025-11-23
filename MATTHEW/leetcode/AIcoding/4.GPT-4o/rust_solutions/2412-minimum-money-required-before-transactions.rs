pub fn minimum_money(transactions: Vec<Vec<i32>>) -> i32 {
    let mut total_needed = 0;
    let mut max_loss = 0;

    for transaction in transactions {
        let (gain, loss) = (transaction[0], transaction[1]);
        if gain < loss {
            total_needed += loss - gain;
            max_loss = max_loss.max(loss - gain);
        }
    }

    total_needed + max_loss
}