use std::collections::BinaryHeap;

impl Solution {
    pub fn find_maximized_capital(k: i32, w: i32, profits: Vec<i32>, capital: Vec<i32>) -> i32 {
        let n = profits.len();
        let mut projects: Vec<(i32, i32)> = profits.iter().zip(capital.iter()).map(|(&p, &c)| (c, p)).collect();
        projects.sort();

        let mut pq: BinaryHeap<i32> = BinaryHeap::new();
        let mut current_capital = w;
        let mut project_index = 0;

        for _ in 0..k {
            while project_index < n && projects[project_index].0 <= current_capital {
                pq.push(projects[project_index].1);
                project_index += 1;
            }

            if pq.is_empty() {
                break;
            }

            current_capital += pq.pop().unwrap();
        }

        current_capital
    }
}