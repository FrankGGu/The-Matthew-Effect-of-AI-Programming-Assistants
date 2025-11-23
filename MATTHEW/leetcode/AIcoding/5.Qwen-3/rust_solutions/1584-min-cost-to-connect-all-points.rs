impl Solution {

use std::cmp::Reverse;
use std::collections::BinaryHeap;

impl Solution {
    pub fn min_cost_to_connect_all_points(mut points: Vec<Vec<i32>>) -> i32 {
        let n = points.len();
        let mut visited = vec![false; n];
        let mut heap = BinaryHeap::new();
        let mut total_cost = 0;
        let mut edges_used = 0;

        // Start with the first point
        for j in 1..n {
            let cost = (points[0][0] - points[j][0]).abs() + (points[0][1] - points[j][1]).abs();
            heap.push(Reverse((cost, 0, j)));
        }

        while edges_used < n - 1 {
            let Reverse((cost, u, v)) = heap.pop().unwrap();
            if visited[v] {
                continue;
            }
            visited[v] = true;
            total_cost += cost;
            edges_used += 1;

            for j in 0..n {
                if !visited[j] {
                    let cost = (points[v][0] - points[j][0]).abs() + (points[v][1] - points[j][1]).abs();
                    heap.push(Reverse((cost, v, j)));
                }
            }
        }

        total_cost
    }
}
}