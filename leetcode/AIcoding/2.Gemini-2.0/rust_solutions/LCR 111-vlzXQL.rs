use std::collections::{HashMap, HashSet, VecDeque};

impl Solution {
    pub fn calc_equation(
        equations: Vec<Vec<String>>,
        values: Vec<f64>,
        queries: Vec<Vec<String>>,
    ) -> Vec<f64> {
        let mut graph: HashMap<String, Vec<(String, f64)>> = HashMap::new();

        for i in 0..equations.len() {
            let equation = &equations[i];
            let value = values[i];

            graph
                .entry(equation[0].clone())
                .or_insert(Vec::new())
                .push((equation[1].clone(), value));
            graph
                .entry(equation[1].clone())
                .or_insert(Vec::new())
                .push((equation[0].clone(), 1.0 / value));
        }

        let mut results: Vec<f64> = Vec::new();

        for query in &queries {
            let start = &query[0];
            let end = &query[1];

            if !graph.contains_key(start) || !graph.contains_key(end) {
                results.push(-1.0);
                continue;
            }

            let mut queue: VecDeque<(String, f64)> = VecDeque::new();
            let mut visited: HashSet<String> = HashSet::new();

            queue.push_back((start.clone(), 1.0));
            visited.insert(start.clone());

            let mut found = false;
            let mut result = -1.0;

            while !queue.is_empty() {
                let (current, value) = queue.pop_front().unwrap();

                if current == *end {
                    result = value;
                    found = true;
                    break;
                }

                if let Some(neighbors) = graph.get(&current) {
                    for (neighbor, weight) in neighbors {
                        if !visited.contains(neighbor) {
                            queue.push_back((neighbor.clone(), value * weight));
                            visited.insert(neighbor.clone());
                        }
                    }
                }
            }

            results.push(result);
        }

        results
    }
}