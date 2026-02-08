use std::collections::HashMap;
use std::cmp::min;

pub fn min_score(n: i32, roads: Vec<Vec<i32>>) -> i32 {
    let mut graph: HashMap<i32, Vec<(i32, i32)>> = HashMap::new();

    for road in roads {
        graph.entry(road[0]).or_insert(Vec::new()).push((road[1], road[2]));
        graph.entry(road[1]).or_insert(Vec::new()).push((road[0], road[2]));
    }

    let mut visited = vec![false; (n + 1) as usize];
    let mut min_score = i32::MAX;
    let mut stack = vec![1];

    while let Some(node) = stack.pop() {
        if visited[node as usize] {
            continue;
        }
        visited[node as usize] = true;

        for &(neighbor, score) in graph.get(&node).unwrap_or(&Vec::new()) {
            if !visited[neighbor as usize] {
                min_score = min(min_score, score);
                stack.push(neighbor);
            }
        }
    }

    min_score
}