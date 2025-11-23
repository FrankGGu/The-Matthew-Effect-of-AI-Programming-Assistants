impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn calc_equation(equations: Vec<Vec<String>>, values: Vec<f64>, queries: Vec<Vec<String>>) -> Vec<f64> {
        let mut graph = HashMap::new();

        for (i, eq) in equations.iter().enumerate() {
            let a = &eq[0];
            let b = &eq[1];
            let val = values[i];

            graph.entry(a).or_insert_with(HashMap::new).insert(b, val);
            graph.entry(b).or_insert_with(HashMap::new).insert(a, 1.0 / val);
        }

        let mut result = Vec::new();

        for query in queries {
            let a = &query[0];
            let b = &query[1];

            if !graph.contains_key(a) || !graph.contains_key(b) {
                result.push(-1.0);
                continue;
            }

            if a == b {
                result.push(1.0);
                continue;
            }

            let mut visited = HashMap::new();
            let mut queue = VecDeque::new();
            queue.push_back((a, 1.0));
            visited.insert(a, true);

            let mut found = false;

            while let Some((node, val)) = queue.pop_front() {
                if node == b {
                    result.push(val);
                    found = true;
                    break;
                }

                if let Some(neighbors) = graph.get(node) {
                    for (neighbor, weight) in neighbors {
                        if !visited.contains_key(neighbor) {
                            visited.insert(neighbor, true);
                            queue.push_back((neighbor, val * weight));
                        }
                    }
                }
            }

            if !found {
                result.push(-1.0);
            }
        }

        result
    }
}
}