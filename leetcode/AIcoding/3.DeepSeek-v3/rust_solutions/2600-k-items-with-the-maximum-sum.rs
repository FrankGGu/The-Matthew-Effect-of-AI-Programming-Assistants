impl Solution {
    pub fn k_items_with_maximum_sum(num_ones: i32, num_zeros: i32, num_neg_ones: i32, k: i32) -> i32 {
        let mut res = 0;
        let mut k = k;

        let take_ones = std::cmp::min(num_ones, k);
        res += take_ones;
        k -= take_ones;
        if k == 0 {
            return res;
        }

        let take_zeros = std::cmp::min(num_zeros, k);
        k -= take_zeros;
        if k == 0 {
            return res;
        }

        let take_neg_ones = std::cmp::min(num_neg_ones, k);
        res -= take_neg_ones;
        res
    }
}