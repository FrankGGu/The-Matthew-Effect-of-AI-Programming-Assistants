impl Solution {
    pub fn max_k_items(k: i32, num_on: i32, num_off: i32) -> i32 {
        let total = num_on + k;
        let max_items = total - num_off;
        max_items.max(0).min(k)
    }
}