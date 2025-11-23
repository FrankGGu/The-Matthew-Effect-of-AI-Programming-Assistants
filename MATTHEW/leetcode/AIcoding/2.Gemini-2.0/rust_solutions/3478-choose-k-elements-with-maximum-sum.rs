impl Solution {
    pub fn k_items_with_maximum_sum(num_positive: i32, num_negative: i32, k: i32) -> i32 {
        if k <= num_positive {
            k
        } else if k <= num_positive + num_negative {
            num_positive
        } else {
            num_positive - (k - num_positive - num_negative)
        }
    }
}