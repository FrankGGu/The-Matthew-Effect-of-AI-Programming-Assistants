impl Solution {

use std::collections::BinaryHeap;

struct Solution;

impl Solution {
    pub fn find_maximized_capital(mut k: i32, mut w: i32, profits: Vec<i32>, capital: Vec<i32>) -> i32 {
        let mut projects = Vec::new();
        for i in 0..profits.len() {
            projects.push((capital[i], profits[i]));
        }
        projects.sort_by(|a, b| a.0.cmp(&b.0));

        let mut heap = BinaryHeap::new();
        let mut i = 0;

        while k > 0 {
            while i < projects.len() && projects[i].0 <= w {
                heap.push(projects[i].1);
                i += 1;
            }

            if let Some(max_profit) = heap.pop() {
                w += max_profit;
            } else {
                break;
            }

            k -= 1;
        }

        w
    }
}
}