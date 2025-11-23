impl Solution {
    pub fn k_items_with_maximum_sum(num_ones: i32, num_zeros: i32, num_neg_ones: i32, k: i32) -> i32 {
        let mut current_k = k;
        let mut sum = 0;

        let take_ones = current_k.min(num_ones);
        sum += take_ones;
        current_k -= take_ones;

        if current_k == 0 {
            return sum;
        }

        let take_zeros = current_k.min(num_zeros);
        current_k -= take_zeros;

        if current_k == 0 {
            return sum;
        }

        let take_neg_ones = current_k.min(num_neg_ones);
        sum -= take_neg_ones;

        sum
    }
}