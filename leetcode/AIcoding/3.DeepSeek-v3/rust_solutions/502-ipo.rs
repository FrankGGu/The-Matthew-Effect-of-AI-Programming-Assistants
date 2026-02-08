use std::collections::BinaryHeap;

impl Solution {
    pub fn find_maximized_capital(k: i32, w: i32, profits: Vec<i32>, capital: Vec<i32>) -> i32 {
        let mut w = w;
        let k = k as usize;
        let n = profits.len();
        let mut projects: Vec<(i32, i32)> = capital.into_iter().zip(profits.into_iter()).collect();
        projects.sort_unstable();

        let mut heap = BinaryHeap::new();
        let mut i = 0;

        for _ in 0..k {
            while i < n && projects[i].0 <= w {
                heap.push(projects[i].1);
                i += 1;
            }
            if let Some(profit) = heap.pop() {
                w += profit;
            } else {
                break;
            }
        }

        w
    }
}