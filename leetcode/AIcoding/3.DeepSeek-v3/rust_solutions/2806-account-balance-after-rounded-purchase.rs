impl Solution {
    pub fn account_balance_after_purchase(purchase_amount: i32) -> i32 {
        let rounded = ((purchase_amount + 5) / 10) * 10;
        100 - rounded
    }
}