struct Solution;

impl Solution {
    pub fn maximum_beauty(items: Vec<Vec<i32>>, queries: Vec<i32>) -> Vec<i32> {
        let mut sorted_items: Vec<(i32, i32)> = items
            .into_iter()
            .map(|item| (item[0], item[1]))
            .collect();
        sorted_items.sort_unstable_by_key(|item| item.0);

        let mut sorted_queries: Vec<(i32, usize)> = queries
            .into_iter()
            .enumerate()
            .map(|(i, q)| (q, i))
            .collect();
        sorted_queries.sort_unstable_by_key(|query| query.0);

        let mut results: Vec<i32> = vec![0; sorted_queries.len()];
        let mut item_ptr = 0;
        let mut current_max_beauty = 0;

        for (q_val, original_idx) in sorted_queries {
            while item_ptr < sorted_items.len() && sorted_items[item_ptr].0 <= q_val {
                current_max_beauty = current_max_beauty.max(sorted_items[item_ptr].1);
                item_ptr += 1;
            }
            results[original_idx] = current_max_beauty;
        }

        results
    }
}