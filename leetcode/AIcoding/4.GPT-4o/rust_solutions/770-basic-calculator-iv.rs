use std::collections::HashMap;

pub fn basic_calculator_iv(equations: Vec<String>, values: Vec<f64>, queries: Vec<String>) -> Vec<f64> {
    let mut graph: HashMap<String, HashMap<String, f64>> = HashMap::new();

    for (equation, value) in equations.iter().zip(values.iter()) {
        let (a, b) = equation.split_once("=").unwrap();
        let a = a.trim().to_string();
        let b = b.trim().to_string();

        graph.entry(a.clone()).or_default().insert(b.clone(), *value);
        graph.entry(b).or_default().insert(a, 1.0 / value);
    }

    fn dfs(
        graph: &HashMap<String, HashMap<String, f64>>, 
        visited: &mut HashMap<String, bool>, 
        current: &str, 
        target: &str, 
        product: f64
    ) -> f64 {
        if current == target {
            return product;
        }
        if let Some(neighbors) = graph.get(current) {
            for (&neighbor, &value) in neighbors {
                if visited.insert(neighbor.clone(), true).is_none() {
                    let result = dfs(graph, visited, &neighbor, target, product * value);
                    if result != -1.0 {
                        return result;
                    }
                    visited.remove(&neighbor);
                }
            }
        }
        -1.0
    }

    queries.iter().map(|query| {
        let (a, b) = query.split_once("=").unwrap();
        let a = a.trim();
        let b = b.trim();
        if graph.contains_key(a) && graph.contains_key(b) {
            let mut visited = HashMap::new();
            let result = dfs(&graph, &mut visited, a, b, 1.0);
            if result == -1.0 { -1.0 } else { result }
        } else {
            -1.0
        }
    }).collect()
}