impl Solution {
    pub fn odd_even_transactions(transactions: Vec<i32>) -> Vec<i64> {
        let mut even_sum: i64 = 0;
        let mut odd_sum: i64 = 0;

        for transaction in transactions {
            if transaction % 2 == 0 {
                even_sum += transaction as i64;
            } else {
                odd_sum += transaction as i64;
            }
        }

        vec![even_sum, odd_sum]
    }
}