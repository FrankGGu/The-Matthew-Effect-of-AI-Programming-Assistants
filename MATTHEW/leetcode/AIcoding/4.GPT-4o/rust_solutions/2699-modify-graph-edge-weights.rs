pub fn modify_graph_edges(n: i32, edges: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    let mut graph = vec![vec![]; n as usize + 1];
    let mut edge_indices = vec![];

    for (i, edge) in edges.iter().enumerate() {
        let (u, v, w) = (edge[0], edge[1], edge[2]);
        graph[u as usize].push((v, w, i));
        graph[v as usize].push((u, w, i));
        if w == -1 {
            edge_indices.push((u, v, i));
        }
    }

    let mut result = edges.clone();
    let mut used = vec![false; n as usize + 1];
    let mut min_weight = 1;

    for i in 1..=n {
        if !used[i as usize] {
            let mut stack = vec![i];
            let mut connected_nodes = vec![];

            while let Some(node) = stack.pop() {
                if !used[node as usize] {
                    used[node as usize] = true;
                    connected_nodes.push(node);
                    for &(neighbor, _, _) in &graph[node as usize] {
                        if !used[neighbor as usize] {
                            stack.push(neighbor);
                        }
                    }
                }
            }

            for j in (0..connected_nodes.len()).step_by(2) {
                if j + 1 < connected_nodes.len() {
                    result[edge_indices[min_weight - 1].2][2] = min_weight;
                    min_weight += 1;
                }
            }
        }
    }

    result
}