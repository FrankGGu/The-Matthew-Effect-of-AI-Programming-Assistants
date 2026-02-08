pub fn max_k_divisible_components(n: i32, edges: Vec<Vec<i32>>, k: i32) -> i32 {
    use std::collections::{HashMap, HashSet, VecDeque};

    let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
    for edge in edges {
        graph.entry(edge[0]).or_default().push(edge[1]);
        graph.entry(edge[1]).or_default().push(edge[0]);
    }

    let mut visited = HashSet::new();
    let mut components = 0;

    fn bfs(start: i32, graph: &HashMap<i32, Vec<i32>>, visited: &mut HashSet<i32>, k: i32) -> i32 {
        let mut queue = VecDeque::new();
        queue.push_back(start);
        visited.insert(start);
        let mut size = 0;

        while let Some(node) = queue.pop_front() {
            size += 1;
            for &neighbor in &graph[&node] {
                if !visited.contains(&neighbor) {
                    visited.insert(neighbor);
                    queue.push_back(neighbor);
                }
            }
        }
        size
    }

    for i in 1..=n {
        if !visited.contains(&i) {
            let size = bfs(i, &graph, &mut visited, k);
            if size % k == 0 {
                components += 1;
            }
        }
    }

    components
}