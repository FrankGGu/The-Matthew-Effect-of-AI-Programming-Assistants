impl Solution {
    pub fn account_balance_after_purchase(purchase_amount: i32) -> i32 {
        let rounded_amount = ((purchase_amount as f64 / 10.0).round() * 10.0) as i32;
        100 - rounded_amount
    }
}