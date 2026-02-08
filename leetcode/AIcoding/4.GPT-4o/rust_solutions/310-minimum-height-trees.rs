use std::collections::HashMap;
use std::collections::VecDeque;

pub fn find_min_height_trees(n: i32, edges: Vec<Vec<i32>>) -> Vec<i32> {
    if n == 1 {
        return vec![0];
    }

    let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
    for edge in edges {
        graph.entry(edge[0]).or_default().push(edge[1]);
        graph.entry(edge[1]).or_default().push(edge[0]);
    }

    let mut leaves: VecDeque<i32> = (0..n).filter(|&i| graph[&i].len() == 1).collect();

    let mut remaining_nodes = n;
    while remaining_nodes > 2 {
        let leaves_count = leaves.len();
        remaining_nodes -= leaves_count;

        for _ in 0..leaves_count {
            let leaf = leaves.pop_front().unwrap();
            if let Some(neighbors) = graph.get_mut(&leaf) {
                if let Some(&neighbor) = neighbors.get(0) {
                    neighbors.clear();
                    if let Some(neighbor_neighbors) = graph.get_mut(&neighbor) {
                        neighbor_neighbors.retain(|&x| x != leaf);
                        if neighbor_neighbors.len() == 1 {
                            leaves.push_back(neighbor);
                        }
                    }
                }
            }
        }
    }

    leaves.into_iter().collect()
}