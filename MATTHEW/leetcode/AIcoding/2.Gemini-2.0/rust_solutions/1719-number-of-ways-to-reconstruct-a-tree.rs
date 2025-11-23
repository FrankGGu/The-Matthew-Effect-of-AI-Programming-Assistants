use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn check_ways(pairs: Vec<Vec<i32>>) -> i32 {
        let mut adj: HashMap<i32, HashSet<i32>> = HashMap::new();
        for pair in &pairs {
            let u = pair[0];
            let v = pair[1];
            adj.entry(u).or_insert(HashSet::new()).insert(v);
            adj.entry(v).or_insert(HashSet::new()).insert(u);
        }

        let mut root = -1;
        for (&node, neighbors) in &adj {
            if neighbors.len() == adj.len() - 1 {
                root = node;
                break;
            }
        }

        if root == -1 {
            let mut nodes: HashSet<i32> = HashSet::new();
            for pair in &pairs {
                nodes.insert(pair[0]);
                nodes.insert(pair[1]);
            }

            let mut possible_roots: Vec<i32> = Vec::new();
            for &node in &nodes{
                let mut is_possible_root = true;
                for &neighbor in &nodes {
                    if node != neighbor {
                       if adj.get(&node).map_or(false, |neighbors| !neighbors.contains(&neighbor)){
                           is_possible_root = false;
                           break;
                       }
                    }
                }
                if is_possible_root {
                    possible_roots.push(node);
                }
            }
            if possible_roots.is_empty(){
                return 0;
            } else {
                if possible_roots.len() > 1 {
                    root = possible_roots[0];
                } else {
                     root = possible_roots[0];
                }
            }

        }

        if root == -1 {
            return 0;
        }

        let mut count = 1;
        for (&node, _) in &adj {
            if adj[&node].len() == adj.len() - 1 && node != root {
                count = 2;
                break;
            }
        }

        let mut parent: HashMap<i32, i32> = HashMap::new();
        for (&node, _) in &adj {
            parent.insert(node, -1);
        }

        let mut valid = true;
        for (&node, _) in &adj {
            if node == root {
                continue;
            }
            let mut best_parent = -1;
            let mut min_neighbors = usize::MAX;

            for &neighbor in &adj[&node] {
                if neighbor != root && adj[&neighbor].len() < min_neighbors {
                    min_neighbors = adj[&neighbor].len();
                    best_parent = neighbor;
                } else if neighbor != root && adj[&neighbor].len() == min_neighbors{
                    if neighbor < best_parent{
                        best_parent = neighbor;
                    }
                }
            }

            if best_parent == -1 {
                for &neighbor in &adj[&node]{
                    if neighbor == root {
                        best_parent = root;
                        break;
                    }
                }
            }
            if best_parent == -1 {
                valid = false;
                break;
            }

            parent.insert(node, best_parent);

            if !adj[&best_parent].contains(&node) {
                valid = false;
                break;
            }

            let mut count_neighbors = 0;
            for &neighbor in &adj[&node] {
                if neighbor != best_parent && adj[&best_parent].contains(&neighbor) {
                    count_neighbors += 1;
                }
            }
            if count_neighbors != adj[&node].len() -1 {
                 if adj[&node].len() != 0{
                    valid = false;
                    break;
                 }
            }
        }

        if !valid {
            return 0;
        }

        let mut root_count = 0;
        for (&node, &p) in &parent {
            if p == root {
                root_count += 1;
            }
        }

        if adj.len() > 1 && root_count > 1{
            count = 2;
        }

        1 * count
    }
}