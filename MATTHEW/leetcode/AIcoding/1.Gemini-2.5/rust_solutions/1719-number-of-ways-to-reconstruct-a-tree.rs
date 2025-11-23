use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn number_of_ways_to_reconstruct_a_tree(pairs: Vec<Vec<i32>>) -> i32 {
        let mut adj: HashMap<i32, HashSet<i32>> = HashMap::new();
        let mut all_nodes: HashSet<i32> = HashSet::new();

        for pair in &pairs {
            let u = pair[0];
            let v = pair[1];
            adj.entry(u).or_insert_with(HashSet::new).insert(v);
            adj.entry(v).or_insert_with(HashSet::new).insert(u);
            all_nodes.insert(u);
            all_nodes.insert(v);
        }

        let n = all_nodes.len();

        if n == 0 {
            return 0;
        }

        // Collect all unique nodes into a vector and sort them by degree (descending).
        // The node with the largest degree is a candidate for the root.
        let mut sorted_nodes: Vec<i32> = all_nodes.into_iter().collect();
        sorted_nodes.sort_by(|&a, &b| adj[&b].len().cmp(&adj[&a].len()));

        let mut ways = 1;

        // Iterate through nodes, starting from the second node (index 1), as the first node (index 0) is the root candidate.
        for u_idx in 1..n {
            let u = sorted_nodes[u_idx];
            let mut valid_parents = Vec::new();

            // Iterate through potential parents 'p' which are nodes that appear earlier in the sorted list (i.e., have a degree >= degree of 'u').
            for p_idx in 0..u_idx {
                let p = sorted_nodes[p_idx];

                // 'p' must be a neighbor of 'u' to be its parent.
                if !adj[&u].contains(&p) {
                    continue;
                }

                // The core property: for 'p' to be an ancestor of 'u', every neighbor 'x' of 'u' (excluding 'p' itself)
                // must also be a neighbor of 'p'.
                // This means adj[u] \ {p} must be a subset of adj[p] \ {u}.
                let mut is_subset = true;
                for &x in adj[&u].iter() {
                    if x == p { // Exclude 'p' from adj[u] for the subset check
                        continue;
                    }
                    if !adj[&p].contains(&x) { // Check if 'x' is in adj[p]
                        is_subset = false;
                        break;
                    }
                }

                if is_subset {
                    valid_parents.push(p);
                }
            }

            // If no valid parent is found for 'u', then no such tree can be reconstructed.
            if valid_parents.is_empty() {
                return 0;
            }

            let mut min_adj_len = usize::MAX;
            let mut chosen_parent = -1; 

            // Among valid parents, choose the one with the smallest degree (most "direct" ancestor).
            for &p in valid_parents.iter() {
                if adj[&p].len() < min_adj_len {
                    min_adj_len = adj[&p].len();
                    chosen_parent = p;
                } else if adj[&p].len() == min_adj_len {
                    // If multiple parents have the same minimal degree, it implies an ambiguity
                    // in choosing the parent for 'u', thus multiple ways to reconstruct.
                    ways = 2;
                }
            }

            // Another condition for ambiguity: if 'u' and its chosen parent 'chosen_parent'
            // have the exact same set of neighbors (i.e., same degree and the subset condition holds).
            // This means they are structurally indistinguishable in terms of their immediate connections.
            if adj[&u].len() == adj[&chosen_parent].len() {
                ways = 2;
            }
        }

        ways
    }
}