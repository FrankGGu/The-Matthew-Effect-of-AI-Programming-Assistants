use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn calc_equation(
        equations: Vec<Vec<String>>,
        values: Vec<f64>,
        queries: Vec<Vec<String>>,
    ) -> Vec<f64> {
        let mut graph: HashMap<String, Vec<(String, f64)>> = HashMap::new();
        for i in 0..equations.len() {
            let eq = &equations[i];
            let val = values[i];
            graph.entry(eq[0].clone()).or_insert(Vec::new()).push((eq[1].clone(), val));
            graph.entry(eq[1].clone()).or_insert(Vec::new()).push((eq[0].clone(), 1.0 / val));
        }

        let mut results: Vec<f64> = Vec::new();
        for query in &queries {
            let start = &query[0];
            let end = &query[1];

            if !graph.contains_key(start) || !graph.contains_key(end) {
                results.push(-1.0);
                continue;
            }

            let mut visited: HashSet<String> = HashSet::new();
            let mut stack: Vec<(String, f64)> = Vec::new();
            stack.push((start.clone(), 1.0));
            visited.insert(start.clone());

            let mut found = false;
            let mut result = -1.0;

            while let Some((node, value)) = stack.pop() {
                if node == *end {
                    result = value;
                    found = true;
                    break;
                }

                if let Some(neighbors) = graph.get(&node) {
                    for (neighbor, weight) in neighbors {
                        if !visited.contains(neighbor) {
                            stack.push((neighbor.clone(), value * weight));
                            visited.insert(neighbor.clone());
                        }
                    }
                }
            }

            if found {
                results.push(result);
            } else {
                results.push(-1.0);
            }
        }

        results
    }
}

struct Solution;