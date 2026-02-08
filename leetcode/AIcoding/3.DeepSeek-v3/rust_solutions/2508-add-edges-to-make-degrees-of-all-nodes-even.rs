use std::collections::HashSet;

impl Solution {
    pub fn is_possible(n: i32, edges: Vec<Vec<i32>>) -> bool {
        let n = n as usize;
        let mut adj = vec![HashSet::new(); n + 1];
        let mut odd_degree_nodes = Vec::new();

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].insert(v);
            adj[v].insert(u);
        }

        for i in 1..=n {
            if adj[i].len() % 2 != 0 {
                odd_degree_nodes.push(i);
            }
        }

        if odd_degree_nodes.len() == 0 {
            return true;
        }

        if odd_degree_nodes.len() == 2 {
            let a = odd_degree_nodes[0];
            let b = odd_degree_nodes[1];

            if !adj[a].contains(&b) {
                return true;
            }

            for c in 1..=n {
                if c != a && c != b && !adj[a].contains(&c) && !adj[b].contains(&c) {
                    return true;
                }
            }

            return false;
        }

        if odd_degree_nodes.len() == 4 {
            let a = odd_degree_nodes[0];
            let b = odd_degree_nodes[1];
            let c = odd_degree_nodes[2];
            let d = odd_degree_nodes[3];

            return (!adj[a].contains(&b) && !adj[c].contains(&d)) ||
                   (!adj[a].contains(&c) && !adj[b].contains(&d)) ||
                   (!adj[a].contains(&d) && !adj[b].contains(&c));
        }

        false
    }
}