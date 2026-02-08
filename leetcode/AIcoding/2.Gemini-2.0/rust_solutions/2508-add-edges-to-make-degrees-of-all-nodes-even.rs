impl Solution {
    pub fn is_possible(n: i32, edges: Vec<Vec<i32>>) -> bool {
        let n = n as usize;
        let mut adj = vec![Vec::new(); n + 1];
        let mut degree = vec![0; n + 1];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
            degree[u] += 1;
            degree[v] += 1;
        }

        let mut odd_nodes = Vec::new();
        for i in 1..=n {
            if degree[i] % 2 != 0 {
                odd_nodes.push(i);
            }
        }

        if odd_nodes.len() == 0 {
            return true;
        }

        if odd_nodes.len() == 2 {
            let u = odd_nodes[0];
            let v = odd_nodes[1];
            if adj[u].contains(&v) {
                for i in 1..=n {
                    if i != u && i != v {
                        return true;
                    }
                }
                return false;
            } else {
                return true;
            }
        }

        if odd_nodes.len() == 4 {
            let a = odd_nodes[0];
            let b = odd_nodes[1];
            let c = odd_nodes[2];
            let d = odd_nodes[3];

            if !adj[a].contains(&b) && !adj[c].contains(&d) {
                return true;
            }
            if !adj[a].contains(&c) && !adj[b].contains(&d) {
                return true;
            }
            if !adj[a].contains(&d) && !adj[b].contains(&c) {
                return true;
            }

            return false;
        }

        return false;
    }
}