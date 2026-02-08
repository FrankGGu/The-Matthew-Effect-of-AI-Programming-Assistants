use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn min_trio_degree(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let mut graph: HashMap<i32, HashSet<i32>> = HashMap::new();
        let mut degrees: Vec<i32> = vec![0; (n + 1) as usize];

        for edge in &edges {
            graph.entry(edge[0]).or_insert_with(HashSet::new).insert(edge[1]);
            graph.entry(edge[1]).or_insert_with(HashSet::new).insert(edge[0]);
            degrees[edge[0] as usize] += 1;
            degrees[edge[1] as usize] += 1;
        }

        let mut min_degree = i32::MAX;
        let edges_set: HashSet<(i32, i32)> = edges.iter().map(|e| (e[0], e[1])).collect();

        for &node1 in &graph {
            for &node2 in &graph {
                for &node3 in &graph {
                    if node1 != node2 && node1 != node3 && node2 != node3 {
                        if graph[&node1].contains(&node2) && graph[&node1].contains(&node3) && graph[&node2].contains(&node3) {
                            let degree = degrees[node1 as usize] + degrees[node2 as usize] + degrees[node3 as usize] - 6;
                            min_degree = min_degree.min(degree);
                        }
                    }
                }
            }
        }

        if min_degree == i32::MAX { -1 } else { min_degree }
    }
}