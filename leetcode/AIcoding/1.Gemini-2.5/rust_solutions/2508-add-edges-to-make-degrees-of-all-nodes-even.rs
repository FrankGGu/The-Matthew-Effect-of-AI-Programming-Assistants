use std::collections::HashSet;

impl Solution {
    pub fn is_possible(n: i32, edges: Vec<Vec<i32>>) -> bool {
        let n_usize = n as usize;
        let mut degrees = vec![0; n_usize + 1];
        let mut adj_set: HashSet<(i32, i32)> = HashSet::new();

        for edge in edges {
            let u = edge[0];
            let v = edge[1];
            degrees[u as usize] += 1;
            degrees[v as usize] += 1;
            adj_set.insert((u.min(v), u.max(v)));
        }

        let mut odd_degree_nodes: Vec<i32> = Vec::new();
        for i in 1..=n {
            if degrees[i as usize] % 2 != 0 {
                odd_degree_nodes.push(i);
            }
        }

        match odd_degree_nodes.len() {
            0 => {
                true
            }
            2 => {
                let u = odd_degree_nodes[0];
                let v = odd_degree_nodes[1];
                !adj_set.contains(&(u.min(v), u.max(v)))
            }
            4 => {
                let a = odd_degree_nodes[0];
                let b = odd_degree_nodes[1];
                let c = odd_degree_nodes[2];
                let d = odd_degree_nodes[3];

                if !adj_set.contains(&(a.min(b), a.max(b))) && !adj_set.contains(&(c.min(d), c.max(d))) {
                    return true;
                }

                if !adj_set.contains(&(a.min(c), a.max(c))) && !adj_set.contains(&(b.min(d), b.max(d))) {
                    return true;
                }

                if !adj_set.contains(&(a.min(d), a.max(d))) && !adj_set.contains(&(b.min(c), b.max(c))) {
                    return true;
                }

                false
            }
            _ => {
                false
            }
        }
    }
}