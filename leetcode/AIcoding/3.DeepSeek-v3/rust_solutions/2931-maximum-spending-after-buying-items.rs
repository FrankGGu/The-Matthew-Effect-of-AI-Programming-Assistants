impl Solution {
    pub fn max_spending(values: Vec<Vec<i32>>) -> i64 {
        let mut items = Vec::new();
        for row in values {
            for val in row {
                items.push(val as i64);
            }
        }
        items.sort_unstable();
        let mut total = 0;
        for (day, &price) in items.iter().enumerate() {
            total += (day as i64 + 1) * price;
        }
        total
    }
}