impl Solution {
    pub fn minimum_money(transactions: Vec<Vec<i32>>) -> i64 {
        let mut loss_tx: Vec<Vec<i32>> = Vec::new();
        let mut gain_tx: Vec<Vec<i32>> = Vec::new();

        for tx in transactions {
            let cost = tx[0];
            let cashback = tx[1];
            if cost > cashback {
                loss_tx.push(tx);
            } else {
                gain_tx.push(tx);
            }
        }

        // Sort loss transactions by cashback in descending order.
        // This prioritizes transactions that return more money,
        // thereby reducing the "debt" for subsequent loss transactions.
        loss_tx.sort_by(|a, b| b[1].cmp(&a[1]));

        // Sort gain transactions by cost in ascending order.
        // These transactions increase or maintain money, so we want to perform
        // the ones with lower cost requirements first when current_balance might be low.
        gain_tx.sort_by(|a, b| a[0].cmp(&b[0]));

        let mut ans: i64 = 0; // Minimum initial money required
        let mut current_balance: i64 = 0; // Money we have, assuming we started with 'ans'

        // Process loss transactions first
        for tx in loss_tx {
            let cost = tx[0] as i64;
            let cashback = tx[1] as i64;

            // To perform this transaction, we need 'cost' money.
            // Our current effective money is 'ans + current_balance'.
            // So, we need 'ans + current_balance >= cost'.
            // This implies 'ans >= cost - current_balance'.
            // We update 'ans' to be the maximum such requirement encountered so far.
            ans = ans.max(cost - current_balance);

            // Update current_balance after completing this transaction.
            current_balance += cashback - cost;
        }

        // Process gain transactions
        for tx in gain_tx {
            let cost = tx[0] as i64;
            let cashback = tx[1] as i64;

            // Apply the same logic for updating 'ans'
            ans = ans.max(cost - current_balance);

            // Update current_balance after completing this transaction.
            current_balance += cashback - cost;
        }

        ans
    }
}