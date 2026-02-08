use std::collections::HashMap;

pub fn calc_equation(equations: Vec<Vec<String>>, values: Vec<f64>, queries: Vec<Vec<String>>) -> Vec<f64> {
    let mut graph: HashMap<String, Vec<(String, f64)>> = HashMap::new();

    for (i, equation) in equations.iter().enumerate() {
        let (a, b) = (&equation[0], &equation[1]);
        graph.entry(a.clone()).or_default().push((b.clone(), values[i]));
        graph.entry(b.clone()).or_default().push((a.clone(), 1.0 / values[i]));
    }

    fn dfs(graph: &HashMap<String, Vec<(String, f64)>>, visited: &mut HashMap<String, bool>, current: &str, target: &str, value: f64) -> f64 {
        if current == target {
            return value;
        }
        visited.insert(current.to_string(), true);
        for (neighbor, weight) in &graph[current] {
            if !visited.get(neighbor).unwrap_or(&false) {
                let res = dfs(graph, visited, neighbor, target, value * weight);
                if res != -1.0 {
                    return res;
                }
            }
        }
        -1.0
    }

    let mut result = Vec::new();
    for query in queries {
        let (a, b) = (&query[0], &query[1]);
        if !graph.contains_key(a) || !graph.contains_key(b) {
            result.push(-1.0);
            continue;
        }
        let mut visited = HashMap::new();
        let res = dfs(&graph, &mut visited, a, b, 1.0);
        result.push(res);
    }
    result
}