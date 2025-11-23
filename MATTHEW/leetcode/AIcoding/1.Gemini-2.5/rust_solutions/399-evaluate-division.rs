use std::collections::{HashMap, HashSet, VecDeque};

impl Solution {
    pub fn calc_equation(equations: Vec<Vec<String>>, values: Vec<f64>, queries: Vec<Vec<String>>) -> Vec<f64> {
        let mut graph: HashMap<String, HashMap<String, f64>> = HashMap::new();

        for i in 0..equations.len() {
            let a = &equations[i][0];
            let b = &equations[i][1];
            let val = values[i];

            graph.entry(a.clone()).or_default().insert(b.clone(), val);
            graph.entry(b.clone()).or_default().insert(a.clone(), 1.0 / val);
        }

        let mut results: Vec<f64> = Vec::new();

        for query in queries {
            let start_node = &query[0];
            let end_node = &query[1];

            if !graph.contains_key(start_node) || !graph.contains_key(end_node) {
                results.push(-1.0);
                continue;
            }

            if start_node == end_node {
                results.push(1.0);
                continue;
            }

            let mut queue: VecDeque<(String, f64)> = VecDeque::new();
            let mut visited: HashSet<String> = HashSet::new();
            let mut found = false;

            queue.push_back((start_node.clone(), 1.0));
            visited.insert(start_node.clone());

            while let Some((current_node, current_product)) = queue.pop_front() {
                if current_node == *end_node {
                    results.push(current_product);
                    found = true;
                    break;
                }

                if let Some(neighbors) = graph.get(&current_node) {
                    for (neighbor, weight) in neighbors {
                        if !visited.contains(neighbor) {
                            visited.insert(neighbor.clone());
                            queue.push_back((neighbor.clone(), current_product * weight));
                        }
                    }
                }
            }

            if !found {
                results.push(-1.0);
            }
        }

        results
    }
}