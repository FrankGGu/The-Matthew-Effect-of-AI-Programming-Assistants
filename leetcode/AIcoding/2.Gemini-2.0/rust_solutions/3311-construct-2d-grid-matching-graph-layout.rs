impl Solution {
    pub fn construct_2d_array(n: i32, edge_list: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut adj = vec![vec![]; n as usize];
        for edge in &edge_list {
            adj[edge[0] as usize].push(edge[1]);
            adj[edge[1] as usize].push(edge[0]);
        }

        let mut ans = vec![vec![]; n as usize];
        let mut visited = vec![false; n as usize];

        for i in 0..n as usize {
            if visited[i] {
                continue;
            }

            let mut queue = std::collections::VecDeque::new();
            queue.push_back(i);
            visited[i] = true;

            while let Some(u) = queue.pop_front() {
                ans[i].push(u as i32);
                for &v in &adj[u] {
                    if !visited[v as usize] {
                        visited[v as usize] = true;
                        queue.push_back(v as usize);
                    }
                }
            }
        }

        ans
    }
}