impl Solution {
    pub fn inventory_management_ii(mut prices: Vec<i32>, k: i32) -> i32 {
        prices.sort_unstable_by(|a, b| b.cmp(a));
        prices.iter().take(k as usize).sum()
    }
}