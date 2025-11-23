use std::collections::VecDeque;

pub fn all_paths_source_target(graph: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
    let target = (graph.len() - 1) as i32;
    let mut result = Vec::new();
    let mut queue = VecDeque::new();
    queue.push_back((0, vec![0]));

    while let Some((node, path)) = queue.pop_front() {
        if node == target {
            result.push(path);
            continue;
        }
        for &next in &graph[node as usize] {
            let mut new_path = path.clone();
            new_path.push(next);
            queue.push_back((next, new_path));
        }
    }

    result
}