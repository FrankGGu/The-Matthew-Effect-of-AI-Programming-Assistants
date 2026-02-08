use std::collections::BinaryHeap;

impl Solution {
    pub fn find_maximized_capital(k: i32, w: i32, profits: Vec<i32>, capital: Vec<i32>) -> i32 {
        let n = profits.len();
        let mut projects: Vec<(i32, i32)> = Vec::with_capacity(n);
        for i in 0..n {
            projects.push((capital[i], profits[i]));
        }

        projects.sort_unstable_by_key(|p| p.0);

        let mut current_capital = w;
        let mut max_heap = BinaryHeap::new();
        let mut project_idx = 0;

        for _ in 0..k {
            while project_idx < n && projects[project_idx].0 <= current_capital {
                max_heap.push(projects[project_idx].1);
                project_idx += 1;
            }

            if let Some(profit) = max_heap.pop() {
                current_capital += profit;
            } else {
                break;
            }
        }

        current_capital
    }
}