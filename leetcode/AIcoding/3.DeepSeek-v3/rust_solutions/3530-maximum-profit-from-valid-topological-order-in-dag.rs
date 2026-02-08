use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn max_profit_topological_order(n: i32, edges: Vec<Vec<i32>>, profit: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut graph: HashMap<usize, Vec<usize>> = HashMap::new();
        let mut in_degree = vec![0; n];
        let mut max_profit = vec![0; n];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            graph.entry(u).or_default().push(v);
            in_degree[v] += 1;
        }

        let mut queue = VecDeque::new();
        for i in 0..n {
            if in_degree[i] == 0 {
                queue.push_back(i);
                max_profit[i] = profit[i];
            }
        }

        while let Some(u) = queue.pop_front() {
            if let Some(neighbors) = graph.get(&u) {
                for &v in neighbors {
                    if max_profit[v] < max_profit[u] + profit[v] {
                        max_profit[v] = max_profit[u] + profit[v];
                    }
                    in_degree[v] -= 1;
                    if in_degree[v] == 0 {
                        queue.push_back(v);
                    }
                }
            }
        }

        *max_profit.iter().max().unwrap_or(&0)
    }
}