use std::collections::HashMap;

impl Solution {
    pub fn max_edge_sum(edges: Vec<Vec<i32>>) -> i64 {
        let mut adj: HashMap<i32, Vec<i32>> = HashMap::new();
        for edge in &edges {
            let u = edge[0];
            let v = edge[1];
            adj.entry(u).or_insert(Vec::new()).push(edge[2]);
            adj.entry(v).or_insert(Vec::new()).push(edge[2]);
        }

        let mut min_val: HashMap<i32, i32> = HashMap::new();
        let mut total_sum: i64 = 0;

        for (node, weights) in &adj {
            if weights.len() >= 2 {
                let mut sorted_weights = weights.clone();
                sorted_weights.sort();
                min_val.insert(*node, sorted_weights[0]);
                total_sum += sorted_weights.iter().map(|&x| x as i64).sum::<i64>();
            }
        }

        let mut min_decrease = i64::max_value();
        for &val in min_val.values() {
            min_decrease = min_decrease.min(val as i64);
        }

        if min_val.is_empty() {
            return 0;
        }

        total_sum - min_decrease
    }
}