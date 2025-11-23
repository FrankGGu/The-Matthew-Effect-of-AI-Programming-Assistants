impl Solution {

use std::collections::BinaryHeap;

impl Solution {
    pub fn min_cost(n: i32, a: Vec<i32>, b: Vec<i32>, c: Vec<i32>, d: Vec<i32>) -> i32 {
        let mut heap = BinaryHeap::new();
        let mut visited = vec![false; n as usize];
        let mut total_cost = 0;

        for i in 0..n {
            heap.push((0, i));
        }

        while let Some((cost, node)) = heap.pop() {
            if visited[node] {
                continue;
            }
            visited[node] = true;
            total_cost += cost;

            for i in 0..n {
                if !visited[i] {
                    let edge_cost = (a[node] - a[i]).abs() + (b[node] - b[i]).abs() + (c[node] - c[i]).abs() + (d[node] - d[i]).abs();
                    heap.push((edge_cost, i));
                }
            }
        }

        total_cost
    }
}
}