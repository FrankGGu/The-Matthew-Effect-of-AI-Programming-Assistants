impl Solution {
    pub fn training_plan(n: i32, edges: Vec<Vec<i32>>, start: i32, end: i32) -> Vec<i32> {
        let mut adj: Vec<Vec<i32>> = vec![vec![]; n as usize];
        for edge in &edges {
            adj[edge[0] as usize].push(edge[1]);
            adj[edge[1] as usize].push(edge[0]);
        }

        let mut queue = std::collections::VecDeque::new();
        queue.push_back(start);
        let mut parent: Vec<i32> = vec![-1; n as usize];
        let mut visited: Vec<bool> = vec![false; n as usize];
        visited[start as usize] = true;

        while !queue.is_empty() {
            let u = queue.pop_front().unwrap();
            if u == end {
                break;
            }
            for &v in &adj[u as usize] {
                if !visited[v as usize] {
                    visited[v as usize] = true;
                    queue.push_back(v);
                    parent[v as usize] = u;
                }
            }
        }

        let mut path = Vec::new();
        let mut curr = end;
        while curr != -1 {
            path.push(curr);
            curr = parent[curr as usize];
        }
        path.reverse();

        path
    }
}