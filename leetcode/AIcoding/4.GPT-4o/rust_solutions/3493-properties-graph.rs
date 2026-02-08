use std::collections::{HashSet, HashMap};

pub fn properties_graph(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
    let mut graph: HashMap<i32, HashSet<i32>> = HashMap::new();
    for edge in edges {
        graph.entry(edge[0]).or_insert(HashSet::new()).insert(edge[1]);
        graph.entry(edge[1]).or_insert(HashSet::new()).insert(edge[0]);
    }

    let mut result = vec![0; n as usize];

    for i in 0..n {
        let neighbors = graph.get(&(i+1)).unwrap_or(&HashSet::new());
        let degree = neighbors.len();
        let mut is_complete = true;
        if degree != (n - 1) as usize {
            is_complete = false;
        }

        let is_connected = degree > 0;

        if is_complete {
            result[i as usize] = 1; // Complete
        } else if is_connected {
            result[i as usize] = 2; // Connected
        } else {
            result[i as usize] = 0; // Isolated
        }
    }

    result
}