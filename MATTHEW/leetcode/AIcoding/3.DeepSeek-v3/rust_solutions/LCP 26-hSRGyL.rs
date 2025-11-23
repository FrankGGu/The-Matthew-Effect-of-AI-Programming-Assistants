use std::collections::HashMap;

impl Solution {
    pub fn is_possible(n: i32, edges: Vec<Vec<i32>>) -> bool {
        let mut graph: HashMap<i32, Vec<i32>> = HashMap::new();
        for edge in edges {
            let u = edge[0];
            let v = edge[1];
            graph.entry(u).or_default().push(v);
            graph.entry(v).or_default().push(u);
        }

        let mut odd_degree_nodes = Vec::new();
        for (&node, neighbors) in &graph {
            if neighbors.len() % 2 != 0 {
                odd_degree_nodes.push(node);
            }
        }
        if graph.len() < n as usize {
            let missing_nodes = n as usize - graph.len();
            for _ in 0..missing_nodes {
                odd_degree_nodes.push(-1);
            }
        }

        let odd_count = odd_degree_nodes.len();
        if odd_count == 0 {
            return true;
        }
        if odd_count == 2 {
            let a = odd_degree_nodes[0];
            let b = odd_degree_nodes[1];
            if !graph.get(&a).map_or(false, |neighbors| neighbors.contains(&b)) {
                return true;
            }
            for node in 1..=n {
                if node != a && node != b {
                    if !graph.get(&node).map_or(false, |neighbors| neighbors.contains(&a))
                        && !graph.get(&node).map_or(false, |neighbors| neighbors.contains(&b))
                    {
                        return true;
                    }
                }
            }
            return false;
        }
        if odd_count == 4 {
            let a = odd_degree_nodes[0];
            let b = odd_degree_nodes[1];
            let c = odd_degree_nodes[2];
            let d = odd_degree_nodes[3];
            if (!graph.get(&a).map_or(false, |neighbors| neighbors.contains(&b))
                && !graph.get(&c).map_or(false, |neighbors| neighbors.contains(&d)))
                || (!graph.get(&a).map_or(false, |neighbors| neighbors.contains(&c))
                    && !graph.get(&b).map_or(false, |neighbors| neighbors.contains(&d))
                || (!graph.get(&a).map_or(false, |neighbors| neighbors.contains(&d)))
                    && !graph.get(&b).map_or(false, |neighbors| neighbors.contains(&c))
            {
                return true;
            }
            return false;
        }
        false
    }
}