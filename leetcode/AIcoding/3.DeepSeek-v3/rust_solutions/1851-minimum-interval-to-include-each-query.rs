use std::collections::{BinaryHeap, HashMap};

impl Solution {
    pub fn min_interval(intervals: Vec<Vec<i32>>, queries: Vec<i32>) -> Vec<i32> {
        let mut intervals = intervals;
        intervals.sort_unstable_by_key(|v| v[0]);
        let mut queries_with_indices: Vec<(i32, usize)> = queries.iter().enumerate().map(|(i, &q)| (q, i)).collect();
        queries_with_indices.sort_unstable_by_key(|&(q, _)| q);

        let mut heap: BinaryHeap<(i32, i32)> = BinaryHeap::new();
        let mut res = vec![-1; queries.len()];
        let mut i = 0;

        for (q, idx) in queries_with_indices {
            while i < intervals.len() && intervals[i][0] <= q {
                let (l, r) = (intervals[i][0], intervals[i][1]);
                if r >= q {
                    heap.push((- (r - l + 1), r));
                }
                i += 1;
            }

            while let Some(&(neg_len, r)) = heap.peek() {
                if r < q {
                    heap.pop();
                } else {
                    res[idx] = -neg_len;
                    break;
                }
            }
        }

        res
    }
}