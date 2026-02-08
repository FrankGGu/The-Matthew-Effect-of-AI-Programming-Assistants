use std::collections::BinaryHeap;
use std::cmp::Reverse;

impl Solution {
    pub fn find_maximized_capital(k: i32, w: i32, profits: Vec<i32>, capital: Vec<i32>) -> i32 {
        let n = profits.len();
        let mut projects: Vec<(i32, i32)> = Vec::with_capacity(n);
        for i in 0..n {
            projects.push((capital[i], profits[i]));
        }
        projects.sort_unstable();

        let mut available: BinaryHeap<i32> = BinaryHeap::new();
        let mut current_capital = w;
        let mut project_index = 0;

        for _ in 0..k {
            while project_index < n && projects[project_index].0 <= current_capital {
                available.push(projects[project_index].1);
                project_index += 1;
            }

            if let Some(profit) = available.pop() {
                current_capital += profit;
            } else {
                break;
            }
        }

        current_capital
    }
}