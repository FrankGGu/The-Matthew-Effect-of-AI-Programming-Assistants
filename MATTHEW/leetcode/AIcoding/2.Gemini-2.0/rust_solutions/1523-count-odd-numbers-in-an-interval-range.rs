impl Solution {
    pub fn count_odd_numbers(low: i32, high: i32) -> i32 {
        if (high - low + 1) % 2 == 0 {
            (high - low + 1) / 2
        } else {
            if low % 2 != 0 || high % 2 != 0 {
                (high - low + 1) / 2 + 1
            } else {
                (high - low + 1) / 2
            }
        }
    }
}