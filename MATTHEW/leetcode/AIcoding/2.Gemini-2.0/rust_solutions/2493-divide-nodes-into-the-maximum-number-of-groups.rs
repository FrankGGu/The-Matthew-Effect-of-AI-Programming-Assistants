use std::collections::VecDeque;

impl Solution {
    pub fn magnificent_sets(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![Vec::new(); n + 1];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut components: Vec<Vec<usize>> = Vec::new();
        let mut visited: Vec<bool> = vec![false; n + 1];

        for i in 1..=n {
            if !visited[i] {
                let mut component: Vec<usize> = Vec::new();
                let mut q: VecDeque<usize> = VecDeque::new();
                q.push_back(i);
                visited[i] = true;
                while let Some(u) = q.pop_front() {
                    component.push(u);
                    for &v in &adj[u] {
                        if !visited[v] {
                            visited[v] = true;
                            q.push_back(v);
                        }
                    }
                }
                components.push(component);
            }
        }

        let mut ans = 0;
        for component in &components {
            if !Self::is_bipartite(&component, &adj) {
                return -1;
            }
            let max_depth = Self::max_depth(&component, &adj);
            ans += max_depth;
        }

        ans
    }

    fn is_bipartite(component: &Vec<usize>, adj: &Vec<Vec<usize>>) -> bool {
        let mut colors: Vec<i32> = vec![0; adj.len()];
        for &start_node in component {
            if colors[start_node] == 0 {
                let mut q: VecDeque<usize> = VecDeque::new();
                q.push_back(start_node);
                colors[start_node] = 1;
                while let Some(u) = q.pop_front() {
                    for &v in &adj[u] {
                        if colors[v] == 0 {
                            colors[v] = -colors[u];
                            q.push_back(v);
                        } else if colors[v] == colors[u] {
                            return false;
                        }
                    }
                }
            }
        }
        true
    }

    fn max_depth(component: &Vec<usize>, adj: &Vec<Vec<usize>>) -> i32 {
        let mut max_depth = 0;
        for &start_node in component {
            let mut depths: Vec<i32> = vec![-1; adj.len()];
            let mut q: VecDeque<(usize, i32)> = VecDeque::new();
            q.push_back((start_node, 1));
            depths[start_node] = 1;
            while let Some((u, depth)) = q.pop_front() {
                max_depth = max_depth.max(depth);
                for &v in &adj[u] {
                    if depths[v] == -1 {
                        depths[v] = depth + 1;
                        q.push_back((v, depth + 1));
                    }
                }
            }
        }
        max_depth
    }
}