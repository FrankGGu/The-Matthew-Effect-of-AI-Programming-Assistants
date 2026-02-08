impl Solution {
    pub fn maximum_beauty(items: Vec<Vec<i32>>, queries: Vec<i32>) -> Vec<i32> {
        let mut items = items;
        items.sort_by_key(|item| item[0]);

        let mut max_beauty = 0;
        let mut max_beauties = Vec::with_capacity(items.len());
        for item in &items {
            max_beauty = max_beauty.max(item[1]);
            max_beauties.push(max_beauty);
        }

        let prices: Vec<i32> = items.into_iter().map(|item| item[0]).collect();

        queries.into_iter().map(|query| {
            let idx = match prices.binary_search(&query) {
                Ok(i) => i,
                Err(i) => if i == 0 { return 0; } else { i - 1 },
            };
            max_beauties[idx]
        }).collect()
    }
}