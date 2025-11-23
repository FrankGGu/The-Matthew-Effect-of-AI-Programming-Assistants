use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn eaten_apples(apples: Vec<i32>, days: Vec<i32>) -> i32 {
        let n = apples.len();
        let mut heap = BinaryHeap::new();
        let mut count = 0;
        let mut i = 0;

        while i < n || !heap.is_empty() {
            if i < n && apples[i] > 0 {
                heap.push(Reverse((i as i32 + days[i], apples[i])));
            }

            while let Some(Reverse((expire, apple))) = heap.pop() {
                if expire > i as i32 {
                    count += 1;
                    if apple > 1 {
                        heap.push(Reverse((expire, apple - 1)));
                    }
                    break;
                }
            }

            i += 1;
        }

        count
    }
}