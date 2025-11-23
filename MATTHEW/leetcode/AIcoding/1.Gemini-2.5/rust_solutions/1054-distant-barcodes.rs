use std::collections::{HashMap, BinaryHeap};

impl Solution {
    pub fn rearrange_barcodes(barcodes: Vec<i32>) -> Vec<i32> {
        if barcodes.is_empty() {
            return Vec::new();
        }

        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &barcode in &barcodes {
            *counts.entry(barcode).or_insert(0) += 1;
        }

        let mut heap: BinaryHeap<(i32, i32)> = BinaryHeap::new();
        for (barcode, count) in counts {
            heap.push((count, barcode));
        }

        let mut result: Vec<i32> = Vec::with_capacity(barcodes.len());
        let mut prev_item: Option<(i32, i32)> = None;

        while let Some((mut count, barcode)) = heap.pop() {
            result.push(barcode);
            count -= 1;

            if let Some((prev_count, prev_barcode)) = prev_item.take() {
                heap.push((prev_count, prev_barcode));
            }

            if count > 0 {
                prev_item = Some((count, barcode));
            }
        }

        result
    }
}