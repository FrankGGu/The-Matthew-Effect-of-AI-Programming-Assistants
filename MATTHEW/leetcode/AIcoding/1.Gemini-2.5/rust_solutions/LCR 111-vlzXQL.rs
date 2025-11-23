use std::collections::HashMap;

struct DSU {
    parent: HashMap<String, String>,
    value: HashMap<String, f64>, // value[node] = node / parent[node]
}

impl DSU {
    fn new() -> Self {
        DSU {
            parent: HashMap::new(),
            value: HashMap::new(),
        }
    }

    // Finds the root of the set containing `node` and the ratio `node / root`.
    // Path compression and value updates are performed.
    fn find(&mut self, node: &str) -> (String, f64) {
        // If node is not in the DSU, initialize it as its own parent with a value of 1.0
        if !self.parent.contains_key(node) {
            self.parent.insert(node.to_string(), node.to_string());
            self.value.insert(node.to_string(), 1.0);
            return (node.to_string(), 1.0);
        }

        let p = self.parent.get(node).unwrap().clone();
        if p == node {
            // `node` is its own parent, so it's a root.
            return (node.to_string(), 1.0);
        }

        // Recursively find the root and the ratio from parent to root
        let (root, parent_val_to_root) = self.find(&p);

        // Path compression: set `node`'s parent directly to `root`
        *self.parent.get_mut(node).unwrap() = root.clone();

        // Update `node`'s value relative to its new parent (`root`)
        // value[node] was node / old_parent
        // parent_val_to_root was old_parent / root
        // new value[node] (node / root) = (node / old_parent) * (old_parent / root)
        *self.value.get_mut(node).unwrap() *= parent_val_to_root;

        (root, self.value.get(node).unwrap().clone())
    }

    // Unions two sets containing `a` and `b` with the relation `a / b = val_ab`.
    fn union(&mut self, a: &str, b: &str, val_ab: f64) {
        let (root_a, val_a_to_root_a) = self.find(a);
        let (root_b, val_b_to_root_b) = self.find(b);

        if root_a != root_b {
            // Make root_a's parent root_b
            self.parent.insert(root_a.clone(), root_b.clone());

            // Calculate the value for root_a relative to root_b
            // We want root_a / root_b
            // We know:
            // a / root_a = val_a_to_root_a
            // b / root_b = val_b_to_root_b
            // a / b = val_ab
            //
            // root_a / root_b = (a / val_a_to_root_a) / (b / val_b_to_root_b)
            //                 = (a / b) * (val_b_to_root_b / val_a_to_root_a)
            //                 = val_ab * val_b_to_root_b / val_a_to_root_a
            self.value.insert(root_a, val_ab * val_b_to_root_b / val_a_to_root_a);
        }
    }
}

impl Solution {
    pub fn calc_equation(equations: Vec<Vec<String>>, values: Vec<f64>, queries: Vec<Vec<String>>) -> Vec<f64> {
        let mut dsu = DSU::new();

        // Process equations to build the DSU
        for i in 0..equations.len() {
            let a = &equations[i][0];
            let b = &equations[i][1];
            let val_ab = values[i];
            dsu.union(a, b, val_ab);
        }

        // Process queries
        let mut results = Vec::with_capacity(queries.len());
        for query in queries {
            let a = &query[0];
            let b = &query[1];

            // Check if both variables exist in the DSU
            if !dsu.parent.contains_key(a) || !dsu.parent.contains_key(b) {
                results.push(-1.0);
                continue;
            }

            let (root_a, val_a_to_root_a) = dsu.find(a);
            let (root_b, val_b_to_root_b) = dsu.find(b);

            if root_a != root_b {
                // Variables are in different sets, no path found
                results.push(-1.0);
            } else {
                // Variables are in the same set, calculate a / b
                // We have:
                // a / root_a = val_a_to_root_a
                // b / root_b = val_b_to_root_b (and root_a == root_b)
                // So, a / b = (a / root_a) / (b / root_a) = val_a_to_root_a / val_b_to_root_b
                results.push(val_a_to_root_a / val_b_to_root_b);
            }
        }

        results
    }
}