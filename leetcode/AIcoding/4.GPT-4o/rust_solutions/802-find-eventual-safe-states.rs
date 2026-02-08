impl Solution {
    pub fn eventual_safe_nodes(graph: Vec<Vec<i32>>) -> Vec<i32> {
        let n = graph.len();
        let mut out_degree = vec![0; n];
        let mut adj_list = vec![vec![]; n];
        for (i, edges) in graph.iter().enumerate() {
            for &node in edges {
                adj_list[node as usize].push(i);
                out_degree[i] += 1;
            }
        }

        let mut safe_nodes = vec![];
        let mut queue = std::collections::VecDeque::new();

        for i in 0..n {
            if out_degree[i] == 0 {
                queue.push_back(i);
            }
        }

        while let Some(node) = queue.pop_front() {
            safe_nodes.push(node);
            for &prev in &adj_list[node] {
                out_degree[prev] -= 1;
                if out_degree[prev] == 0 {
                    queue.push_back(prev);
                }
            }
        }

        safe_nodes.sort();
        safe_nodes
    }
}