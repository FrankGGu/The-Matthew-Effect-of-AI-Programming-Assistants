impl Solution {
    pub fn account_balance_after_rounded_purchase(purchase_amount: i32) -> i32 {
        let last_digit = purchase_amount % 10;
        let rounded_amount;

        if last_digit <= 4 {
            rounded_amount = purchase_amount - last_digit;
        } else {
            rounded_amount = purchase_amount + (10 - last_digit);
        }

        100 - rounded_amount
    }
}