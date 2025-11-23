impl Solution {
    pub fn get_max_spending(cost: Vec<Vec<i32>>) -> i64 {
        let mut items: Vec<i32> = Vec::new();
        for row in cost.iter() {
            items.extend(row);
        }
        items.sort_unstable_by(|a, b| b.cmp(a));

        let mut ans: i64 = 0;
        for (i, &item) in items.iter().enumerate() {
            ans += (i as i64 + 1) * item as i64;
        }

        ans
    }
}