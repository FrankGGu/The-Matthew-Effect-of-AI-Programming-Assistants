use std::collections::BinaryHeap;

pub fn max_sum_queries(nums1: Vec<i32>, nums2: Vec<i32>, queries: Vec<i32>) -> Vec<i32> {
    let mut indexed: Vec<(i32, i32)> = nums1.iter().zip(nums2.iter()).map(|(&a, &b)| (a, b)).collect();
    indexed.sort_by(|a, b| b.0.cmp(&a.0));

    let mut results = vec![0; queries.len()];
    let mut max_heap = BinaryHeap::new();
    let mut current_sum = 0;

    let mut sorted_queries: Vec<(i32, usize)> = queries.iter().cloned().enumerate().collect();
    sorted_queries.sort_by(|a, b| b.0.cmp(&a.0));

    let mut index = 0;

    for (q_value, q_index) in sorted_queries {
        while index < indexed.len() && indexed[index].0 >= q_value {
            max_heap.push(indexed[index].1);
            current_sum += indexed[index].1;
            index += 1;
        }
        results[q_index] = current_sum;
        if !max_heap.is_empty() {
            current_sum -= max_heap.pop().unwrap();
        }
    }

    results
}