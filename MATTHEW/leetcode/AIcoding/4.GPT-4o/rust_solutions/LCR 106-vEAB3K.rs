use std::collections::VecDeque;

pub fn is_bipartite(graph: Vec<Vec<i32>>) -> bool {
    let mut color = vec![0; graph.len()];

    for i in 0..graph.len() {
        if color[i] == 0 {
            let mut queue = VecDeque::new();
            queue.push_back(i);
            color[i] = 1;

            while let Some(node) = queue.pop_front() {
                for &neighbor in &graph[node] {
                    if color[neighbor as usize] == 0 {
                        color[neighbor as usize] = -color[node];
                        queue.push_back(neighbor as usize);
                    } else if color[neighbor as usize] == color[node] {
                        return false;
                    }
                }
            }
        }
    }
    true
}