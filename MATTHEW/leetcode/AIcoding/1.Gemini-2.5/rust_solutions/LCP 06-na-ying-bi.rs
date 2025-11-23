impl Solution {
    pub fn take_coins(coins: Vec<i32>) -> i32 {
        let mut nim_sum = 0;
        for &coin_count in &coins {
            nim_sum ^= coin_count % 3;
        }
        if nim_sum != 0 {
            1
        } else {
            0
        }
    }
}