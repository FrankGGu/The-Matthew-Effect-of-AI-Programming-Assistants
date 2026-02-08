impl Solution {
    pub fn max_amount_after_two_days(mut amount: i32, mut rate: i32) -> i32 {
        let mut max_amount = amount;
        for _ in 0..2 {
            let converted = amount / rate;
            if converted == 0 {
                break;
            }
            amount = amount - converted + converted * converted;
            if amount > max_amount {
                max_amount = amount;
            }
            rate = converted;
        }
        max_amount
    }
}