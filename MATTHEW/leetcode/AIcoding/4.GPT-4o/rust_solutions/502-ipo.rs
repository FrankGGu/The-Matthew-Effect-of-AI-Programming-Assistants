use std::cmp::Reverse;
use std::collections::BinaryHeap;

pub fn ipo(k: i32, w: i32, profits: Vec<i32>, capital: Vec<i32>) -> i32 {
    let mut projects: Vec<(i32, i32)> = profits.into_iter().zip(capital).collect();
    projects.sort_by(|a, b| a.1.cmp(&b.1));

    let mut max_heap = BinaryHeap::new();
    let mut total_profit = w;
    let mut i = 0;

    for _ in 0..k {
        while i < projects.len() && projects[i].1 <= total_profit {
            max_heap.push(Reverse(projects[i].0));
            i += 1;
        }

        if let Some(Reverse(profit)) = max_heap.pop() {
            total_profit += profit;
        } else {
            break;
        }
    }

    total_profit
}