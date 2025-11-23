use std::collections::{HashMap, HashSet};

struct Solution;

impl Solution {
    pub fn calc_equation(equations: Vec<Vec<String>>, values: Vec<f64>, queries: Vec<Vec<String>>) -> Vec<f64> {
        let mut graph: HashMap<String, Vec<(String, f64)>> = HashMap::new();

        for (i, equation) in equations.iter().enumerate() {
            let (a, b) = (&equation[0], &equation[1]);
            graph.entry(a.clone()).or_insert(vec![]).push((b.clone(), values[i]));
            graph.entry(b.clone()).or_insert(vec![]).push((a.clone(), 1.0 / values[i]));
        }

        let mut results = Vec::new();

        for query in queries {
            let (start, end) = (&query[0], &query[1]);
            if !graph.contains_key(start) || !graph.contains_key(end) {
                results.push(-1.0);
                continue;
            }
            let mut visited = HashSet::new();
            let result = Self::dfs(start, end, 1.0, &mut visited, &graph);
            results.push(result);
        }

        results
    }

    fn dfs(
        current: &String,
        target: &String,
        product: f64,
        visited: &mut HashSet<String>,
        graph: &HashMap<String, Vec<(String, f64)>>
    ) -> f64 {
        if current == target {
            return product;
        }
        visited.insert(current.clone());

        for (neighbor, value) in graph.get(current).unwrap() {
            if !visited.contains(neighbor) {
                let res = Self::dfs(neighbor, target, product * value, visited, graph);
                if res != -1.0 {
                    return res;
                }
            }
        }

        visited.remove(current);
        -1.0
    }
}