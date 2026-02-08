use std::collections::BinaryHeap;

impl Solution {
    pub fn max_star_sum(vals: Vec<i32>, edges: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = vals.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut max_sum = i32::MIN;
        for i in 0..n {
            let mut heap = BinaryHeap::new();
            for &neighbor in &adj[i] {
                if vals[neighbor] > 0 {
                    heap.push(vals[neighbor]);
                }
            }

            let mut current_sum = vals[i];
            let mut count = 0;
            while count < k && !heap.is_empty() {
                current_sum += heap.pop().unwrap();
                count += 1;
            }

            max_sum = max_sum.max(current_sum);
        }

        max_sum
    }
}