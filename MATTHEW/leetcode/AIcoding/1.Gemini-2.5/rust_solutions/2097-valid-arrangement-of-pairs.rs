use std::collections::HashMap;

impl Solution {
    pub fn valid_arrangement(pairs: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut adj: HashMap<i32, Vec<i32>> = HashMap::new();
        let mut in_degree: HashMap<i32, i32> = HashMap::new();
        let mut out_degree: HashMap<i32, i32> = HashMap::new();

        for pair in &pairs {
            let u = pair[0];
            let v = pair[1];
            adj.entry(u).or_insert_with(Vec::new).push(v);
            *out_degree.entry(u).or_insert(0) += 1;
            *in_degree.entry(v).or_insert(0) += 1;
        }

        let mut start_node = -1;

        for (&node, &out_d) in &out_degree {
            let in_d = *in_degree.get(&node).unwrap_or(&0);
            if out_d == in_d + 1 {
                start_node = node;
                break;
            }
        }

        if start_node == -1 {
            // If it's an Eulerian circuit, pick any node that has outgoing edges.
            // Problem guarantees a valid arrangement exists, so adj will not be empty.
            start_node = *adj.keys().next().unwrap();
        }

        let mut euler_path_nodes: Vec<i32> = Vec::new();
        let mut stack: Vec<i32> = vec![start_node];

        // Need a mutable version of adj for popping neighbors
        let mut adj_mut = adj; 

        while let Some(u) = stack.last().cloned() {
            if let Some(neighbors) = adj_mut.get_mut(&u) {
                if let Some(v) = neighbors.pop() {
                    stack.push(v);
                } else {
                    // No more outgoing edges from u, add u to the path
                    euler_path_nodes.push(stack.pop().unwrap());
                }
            } else {
                // This case should ideally not be reached for nodes on the path,
                // as they should have an entry in adj_mut.
                // If a node is popped from stack and has no entry in adj_mut, it means
                // it was a start node or a node that was pushed but had no outgoing edges
                // to begin with (which shouldn't happen for a valid path).
                // However, if the entry exists but the vec is empty, the above `else` handles it.
                // This `else` handles cases where `u` itself is not a key in `adj_mut`.
                // For a valid Eulerian path/circuit, all nodes on the path must have been keys.
                // So, this branch implies an error or an edge case not covered.
                // For this problem, it's safe to assume `adj_mut.get_mut(&u)` will return `Some`.
                euler_path_nodes.push(stack.pop().unwrap());
            }
        }

        // The path is built in reverse order by Hierholzer's algorithm
        euler_path_nodes.reverse();

        let mut result: Vec<Vec<i32>> = Vec::new();
        for i in 0..euler_path_nodes.len() - 1 {
            result.push(vec![euler_path_nodes[i], euler_path_nodes[i+1]]);
        }

        result
    }
}