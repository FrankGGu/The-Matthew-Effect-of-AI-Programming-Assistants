use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn eaten_apples(apples: Vec<i32>, days: Vec<i32>) -> i32 {
        let mut heap: BinaryHeap<Reverse<(i32, i32)>> = BinaryHeap::new();
        let mut eaten = 0;
        let n = apples.len();

        for i in 0..n.max(heap.peek().map(|r| r.0 .1 as usize).unwrap_or(0)) + 1 {
            while let Some(Reverse((expiry, _))) = heap.peek() {
                if *expiry <= i as i32 {
                    heap.pop();
                } else {
                    break;
                }
            }

            if i < n {
                if apples[i] > 0 {
                    heap.push(Reverse((i as i32 + days[i], apples[i])));
                }
            }

            if let Some(Reverse((expiry, count))) = heap.pop() {
                if count > 1 {
                    heap.push(Reverse((expiry, count - 1)));
                }
                eaten += 1;
            }
        }

        eaten
    }
}