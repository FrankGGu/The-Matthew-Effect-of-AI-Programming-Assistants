impl Solution {

use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn max_eating_apples(mut apples: Vec<Vec<i32>>, mut days: Vec<i32>) -> i32 {
        let mut heap = BinaryHeap::new();
        let mut time = 0;
        let mut result = 0;
        let mut i = 0;
        let n = apples.len();

        while i < n || !heap.is_empty() {
            if i < n {
                let (count, expire) = (apples[i][0], apples[i][1]);
                if count > 0 {
                    heap.push(Reverse((expire, count)));
                }
                i += 1;
            }

            while let Some(Reverse((expire, count))) = heap.peek_mut() {
                if *expire < time {
                    heap.pop();
                } else {
                    break;
                }
            }

            if let Some(Reverse((expire, count))) = heap.peek_mut() {
                *count -= 1;
                if *count == 0 {
                    heap.pop();
                }
                result += 1;
            }

            time += 1;
        }

        result
    }
}
}