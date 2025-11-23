use std::collections::HashMap;
use std::collections::VecDeque;

impl Solution {
    pub fn valid_arrangement(pairs: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut graph: HashMap<i32, VecDeque<i32>> = HashMap::new();
        let mut in_degree: HashMap<i32, i32> = HashMap::new();
        let mut out_degree: HashMap<i32, i32> = HashMap::new();

        for pair in &pairs {
            let u = pair[0];
            let v = pair[1];
            graph.entry(u).or_default().push_back(v);
            *out_degree.entry(u).or_default() += 1;
            *in_degree.entry(v).or_default() += 1;
        }

        let mut start = pairs[0][0];
        for (u, &deg) in &out_degree {
            if deg - in_degree.get(u).unwrap_or(&0) == 1 {
                start = *u;
                break;
            }
        }

        let mut stack = vec![];
        let mut path = vec![];
        stack.push(start);

        while let Some(u) = stack.last() {
            let u = *u;
            if let Some(neighbors) = graph.get_mut(&u) {
                if !neighbors.is_empty() {
                    if let Some(v) = neighbors.pop_front() {
                        stack.push(v);
                    }
                    continue;
                }
            }
            if let Some(node) = stack.pop() {
                path.push(node);
            }
        }

        path.reverse();
        let mut result = vec![];
        for i in 1..path.len() {
            result.push(vec![path[i - 1], path[i]]);
        }

        result
    }
}