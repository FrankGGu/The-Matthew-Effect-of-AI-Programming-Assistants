use std::collections::BinaryHeap;

pub fn most_beautiful_item(values: Vec<i32>, queries: Vec<i32>) -> Vec<i32> {
    let n = values.len();
    let mut items: Vec<(i32, i32)> = values.into_iter().enumerate().map(|(i, v)| (v, i as i32)).collect();
    items.sort_by_key(|&(v, _)| v);

    let mut results = vec![-1; queries.len()];
    let mut max_heap = BinaryHeap::new();
    let mut idx = 0;

    let mut sorted_queries: Vec<(i32, usize)> = queries.into_iter().enumerate().collect();
    sorted_queries.sort_by_key(|&(q, _)| q);

    for (query_value, original_index) in sorted_queries {
        while idx < n && items[idx].0 <= query_value {
            max_heap.push(items[idx].1);
            idx += 1;
        }
        results[original_index] = max_heap.peek().cloned().unwrap_or(-1);
    }

    results
}