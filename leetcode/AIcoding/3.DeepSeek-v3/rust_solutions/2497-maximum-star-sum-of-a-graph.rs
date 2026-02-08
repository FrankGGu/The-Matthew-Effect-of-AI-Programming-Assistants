use std::collections::BinaryHeap;

impl Solution {
    pub fn max_star_sum(vals: Vec<i32>, edges: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = vals.len();
        let k = k as usize;
        let mut graph = vec![BinaryHeap::new(); n];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            if vals[v] > 0 {
                graph[u].push(vals[v]);
            }
            if vals[u] > 0 {
                graph[v].push(vals[u]);
            }
        }

        let mut max_sum = i32::MIN;
        for i in 0..n {
            let mut sum = vals[i];
            let mut heap = graph[i].clone();
            let mut count = 0;
            while count < k && !heap.is_empty() {
                if let Some(val) = heap.pop() {
                    sum += val;
                    count += 1;
                }
            }
            max_sum = max_sum.max(sum);
        }

        max_sum
    }
}