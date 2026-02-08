use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn get_order(tasks: Vec<Vec<i32>>) -> Vec<i32> {
        let mut tasks: Vec<(i32, i32, usize)> = tasks.into_iter().enumerate().map(|(i, t)| (t[0], t[1], i)).collect();
        tasks.sort_unstable();

        let mut heap = BinaryHeap::new();
        let mut res = Vec::new();
        let mut time = 0;
        let mut i = 0;
        let n = tasks.len();

        while res.len() < n {
            while i < n && tasks[i].0 <= time {
                heap.push(Reverse((tasks[i].1, tasks[i].2)));
                i += 1;
            }

            if let Some(Reverse((duration, idx))) = heap.pop() {
                time += duration;
                res.push(idx as i32);
            } else if i < n {
                time = tasks[i].0;
            }
        }

        res
    }
}