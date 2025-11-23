pub fn min_reorder(n: i32, connections: Vec<Vec<i32>>) -> i32 {
    use std::collections::{HashMap, HashSet, VecDeque};

    let mut graph: HashMap<i32, Vec<(i32, bool)>> = HashMap::new();
    for conn in connections {
        graph.entry(conn[0]).or_default().push((conn[1], true));
        graph.entry(conn[1]).or_default().push((conn[0], false));
    }

    let mut visited = HashSet::new();
    let mut queue = VecDeque::new();
    queue.push_back(0);
    visited.insert(0);
    let mut reorder_count = 0;

    while let Some(node) = queue.pop_front() {
        for &(neighbor, is_reversed) in &graph[&node] {
            if !visited.contains(&neighbor) {
                visited.insert(neighbor);
                queue.push_back(neighbor);
                if is_reversed {
                    reorder_count += 1;
                }
            }
        }
    }

    reorder_count
}