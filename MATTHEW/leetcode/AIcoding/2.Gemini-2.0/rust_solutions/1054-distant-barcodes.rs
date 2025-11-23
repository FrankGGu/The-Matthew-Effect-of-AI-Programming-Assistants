use std::collections::HashMap;
use std::collections::BinaryHeap;
use std::cmp::Ordering;

#[derive(Eq, PartialEq)]
struct Pair {
    val: i32,
    count: i32,
}

impl Ord for Pair {
    fn cmp(&self, other: &Self) -> Ordering {
        self.count.cmp(&other.count)
    }
}

impl PartialOrd for Pair {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl Solution {
    pub fn rearrange_barcodes(barcodes: Vec<i32>) -> Vec<i32> {
        let mut counts: HashMap<i32, i32> = HashMap::new();
        for &barcode in &barcodes {
            *counts.entry(barcode).or_insert(0) += 1;
        }

        let mut heap: BinaryHeap<Pair> = BinaryHeap::new();
        for (&val, &count) in &counts {
            heap.push(Pair { val, count });
        }

        let mut result: Vec<i32> = Vec::new();
        let mut prev: Option<Pair> = None;

        while !heap.is_empty() {
            let mut current = heap.pop().unwrap();
            result.push(current.val);
            current.count -= 1;

            if let Some(p) = prev {
                if p.count > 0 {
                    heap.push(p);
                }
            }

            prev = if current.count > 0 {
                Some(current)
            } else {
                None
            };
        }

        result
    }
}

struct Solution;