impl Solution {
    pub fn inventory_management_i(mut stock: Vec<i32>, k: i32) -> Vec<i32> {
        stock.sort_unstable();
        stock.into_iter().take(k as usize).collect()
    }
}