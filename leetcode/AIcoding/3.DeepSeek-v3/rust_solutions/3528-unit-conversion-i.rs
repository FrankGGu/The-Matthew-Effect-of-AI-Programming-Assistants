use std::collections::HashMap;

impl Solution {
    pub fn calc_equation(equations: Vec<Vec<String>>, values: Vec<f64>, queries: Vec<Vec<String>>) -> Vec<f64> {
        let mut graph: HashMap<String, HashMap<String, f64>> = HashMap::new();

        for (i, equation) in equations.iter().enumerate() {
            let a = &equation[0];
            let b = &equation[1];
            let value = values[i];

            graph.entry(a.clone()).or_default().insert(b.clone(), value);
            graph.entry(b.clone()).or_default().insert(a.clone(), 1.0 / value);
        }

        queries.into_iter().map(|query| {
            let start = &query[0];
            let end = &query[1];

            if !graph.contains_key(start) || !graph.contains_key(end) {
                return -1.0;
            }

            let mut visited = HashMap::new();
            let mut stack = vec![(start.clone(), 1.0)];

            while let Some((node, current)) = stack.pop() {
                if node == *end {
                    return current;
                }

                if visited.contains_key(&node) {
                    continue;
                }

                visited.insert(node.clone(), true);

                if let Some(neighbors) = graph.get(&node) {
                    for (neighbor, weight) in neighbors {
                        stack.push((neighbor.clone(), current * weight));
                    }
                }
            }

            -1.0
        }).collect()
    }
}