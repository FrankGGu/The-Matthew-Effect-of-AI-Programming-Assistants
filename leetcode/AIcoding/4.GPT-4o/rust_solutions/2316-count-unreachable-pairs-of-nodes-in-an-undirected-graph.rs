use std::collections::VecDeque;

pub fn count_unreachable_pairs(n: i32, edges: Vec<Vec<i32>>) -> i64 {
    let mut graph = vec![Vec::new(); n as usize];
    for edge in edges {
        graph[edge[0] as usize].push(edge[1]);
        graph[edge[1] as usize].push(edge[0]);
    }

    let mut visited = vec![false; n as usize];
    let mut sizes = Vec::new();

    for i in 0..n as usize {
        if !visited[i] {
            let mut size = 0;
            let mut queue = VecDeque::new();
            queue.push_back(i);
            visited[i] = true;

            while let Some(node) = queue.pop_front() {
                size += 1;
                for &neighbor in &graph[node] {
                    if !visited[neighbor as usize] {
                        visited[neighbor as usize] = true;
                        queue.push_back(neighbor);
                    }
                }
            }
            sizes.push(size);
        }
    }

    let total_pairs = sizes.iter().map(|&size| size as i64).sum::<i64>();
    let mut unreachable_pairs = 0;

    for &size in &sizes {
        unreachable_pairs += (total_pairs - size as i64) * size as i64;
        total_pairs -= size as i64;
    }

    unreachable_pairs / 2
}