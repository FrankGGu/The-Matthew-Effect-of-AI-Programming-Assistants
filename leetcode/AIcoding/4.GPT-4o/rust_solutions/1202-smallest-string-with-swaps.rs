use std::collections::HashMap;
use std::collections::HashSet;

pub fn smallest_string_with_swaps(s: String, pairs: Vec<Vec<i32>>) -> String {
    let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();

    for pair in pairs {
        graph.entry(pair[0]).or_default().push(pair[1]);
        graph.entry(pair[1]).or_default().push(pair[0]);
    }

    let mut visited = vec![false; s.len()];
    let mut result = s.chars().collect::<Vec<_>>();

    for i in 0..s.len() {
        if !visited[i] {
            let mut indices = Vec::new();
            let mut chars = Vec::new();
            dfs(i, &graph, &mut visited, &mut indices, &mut chars, &s);
            indices.sort();
            chars.sort();
            for j in 0..indices.len() {
                result[indices[j]] = chars[j];
            }
        }
    }

    result.into_iter().collect()
}

fn dfs(
    node: i32,
    graph: &HashMap<i32, Vec<i32>>,
    visited: &mut Vec<bool>,
    indices: &mut Vec<usize>,
    chars: &mut Vec<char>,
    s: &String,
) {
    visited[node as usize] = true;
    indices.push(node as usize);
    chars.push(s.chars().nth(node as usize).unwrap());

    if let Some(neighbors) = graph.get(&node) {
        for &neighbor in neighbors {
            if !visited[neighbor as usize] {
                dfs(neighbor, graph, visited, indices, chars, s);
            }
        }
    }
}