impl Solution {
    pub fn get_ancestors(n: i32, edges: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n = n as usize;
        let mut graph = vec![vec![]; n];
        let mut in_degree = vec![0; n];
        let mut ancestors = vec![std::collections::BTreeSet::new(); n];

        for edge in edges {
            let from = edge[0] as usize;
            let to = edge[1] as usize;
            graph[from].push(to);
            in_degree[to] += 1;
        }

        let mut queue = std::collections::VecDeque::new();
        for i in 0..n {
            if in_degree[i] == 0 {
                queue.push_back(i);
            }
        }

        while let Some(u) = queue.pop_front() {
            for &v in &graph[u] {
                ancestors[v].insert(u as i32);
                for &anc in &ancestors[u] {
                    ancestors[v].insert(anc);
                }
                in_degree[v] -= 1;
                if in_degree[v] == 0 {
                    queue.push_back(v);
                }
            }
        }

        ancestors.into_iter().map(|set| set.into_iter().collect()).collect()
    }
}