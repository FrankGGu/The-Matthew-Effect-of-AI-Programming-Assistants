use std::collections::BinaryHeap;

pub fn top_k_students(scores: Vec<i32>, k: i32) -> Vec<i32> {
    let mut heap = BinaryHeap::new();
    for &score in &scores {
        heap.push(score);
    }
    let mut result = Vec::new();
    for _ in 0..k {
        if let Some(top) = heap.pop() {
            result.push(top);
        }
    }
    result
}