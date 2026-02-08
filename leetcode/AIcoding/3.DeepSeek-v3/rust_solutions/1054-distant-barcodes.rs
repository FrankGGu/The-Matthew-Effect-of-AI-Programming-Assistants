use std::collections::HashMap;
use std::collections::BinaryHeap;

impl Solution {
    pub fn rearrange_barcodes(barcodes: Vec<i32>) -> Vec<i32> {
        let mut freq = HashMap::new();
        for &code in &barcodes {
            *freq.entry(code).or_insert(0) += 1;
        }

        let mut heap = BinaryHeap::new();
        for (&code, &count) in freq.iter() {
            heap.push((count, code));
        }

        let mut result = Vec::with_capacity(barcodes.len());
        while let Some((count, code)) = heap.pop() {
            if result.is_empty() || *result.last().unwrap() != code {
                result.push(code);
                if count > 1 {
                    heap.push((count - 1, code));
                }
            } else {
                if let Some((next_count, next_code)) = heap.pop() {
                    result.push(next_code);
                    heap.push((count, code));
                    if next_count > 1 {
                        heap.push((next_count - 1, next_code));
                    }
                }
            }
        }

        result
    }
}