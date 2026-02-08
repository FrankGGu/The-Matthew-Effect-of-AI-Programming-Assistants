use std::collections::BinaryHeap;

pub fn min_interval(intervals: Vec<Vec<i32>>, queries: Vec<i32>) -> Vec<i32> {
    let mut events: Vec<(i32, i32, i32)> = intervals.iter()
        .map(|v| (v[0], v[1], v[1] - v[0] + 1))
        .collect();
    let mut queries_with_index: Vec<(i32, usize)> = queries.iter()
        .enumerate()
        .map(|(i, &q)| (q, i))
        .collect();

    events.sort_by_key(|&(start, _, _)| start);
    queries_with_index.sort_by_key(|&(q, _)| q);

    let mut result = vec![-1; queries.len()];
    let mut min_heap = BinaryHeap::new();
    let mut j = 0;

    for (q, idx) in queries_with_index {
        while j < events.len() && events[j].0 <= q {
            min_heap.push((-(events[j].2), events[j].1));
            j += 1;
        }
        while let Some(&(-size, end)) = min_heap.peek() {
            if end < q {
                min_heap.pop();
            } else {
                result[idx] = -size;
                break;
            }
        }
    }

    result
}