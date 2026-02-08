impl Solution {
    pub fn max_spending(mut items: Vec<i32>) -> i64 {
        items.sort_unstable();
        let mut total_spending: i64 = 0;
        for (i, &price) in items.iter().enumerate() {
            total_spending += (i as i64 + 1) * (price as i64);
        }
        total_spending
    }
}