impl Solution {
    pub fn check_if_prerequisite(n: i32, prerequisites: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        let mut in_degree = vec![0; n];
        for prerequisite in &prerequisites {
            graph[prerequisite[0] as usize].push(prerequisite[1] as usize);
            in_degree[prerequisite[1] as usize] += 1;
        }

        let mut reachable = vec![vec![false; n]; n];

        for start_node in 0..n {
            let mut queue = std::collections::VecDeque::new();
            queue.push_back(start_node);
            let mut visited = vec![false; n];
            visited[start_node] = true;

            while let Some(node) = queue.pop_front() {
                for &neighbor in &graph[node] {
                    reachable[start_node][neighbor] = true;
                    if !visited[neighbor] {
                        visited[neighbor] = true;
                        queue.push_back(neighbor);
                    }
                }
            }
        }

        let mut result = Vec::new();
        for query in &queries {
            result.push(reachable[query[0] as usize][query[1] as usize]);
        }

        result
    }
}