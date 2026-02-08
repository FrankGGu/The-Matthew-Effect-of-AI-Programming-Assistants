use std::collections::{HashMap, HashSet};

struct Solution;

impl Solution {
    pub fn maximum_nodes_after_connection(trees: Vec<Vec<i32>>) -> i32 {
        let mut parent: HashMap<i32, i32> = HashMap::new();
        let mut size: HashMap<i32, i32> = HashMap::new();
        let mut visited: HashSet<i32> = HashSet::new();

        for tree in &trees {
            let u = tree[0];
            let v = tree[1];
            parent.insert(u, u);
            parent.insert(v, v);
            size.insert(u, 1);
            size.insert(v, 1);
        }

        fn find(u: i32, parent: &mut HashMap<i32, i32>) -> i32 {
            if parent[&u] != u {
                parent.insert(u, find(parent[&u], parent));
            }
            parent[&u]
        }

        fn union(u: i32, v: i32, parent: &mut HashMap<i32, i32>, size: &mut HashMap<i32, i32>) {
            let root_u = find(u, parent);
            let root_v = find(v, parent);
            if root_u != root_v {
                if size[&root_u] < size[&root_v] {
                    parent.insert(root_u, root_v);
                    *size.get_mut(&root_v).unwrap() += size[&root_u];
                } else {
                    parent.insert(root_v, root_u);
                    *size.get_mut(&root_u).unwrap() += size[&root_v];
                }
            }
        }

        for tree in &trees {
            let u = tree[0];
            let v = tree[1];
            union(u, v, &mut parent, &mut size);
        }

        let mut roots = HashSet::new();
        for &node in parent.keys() {
            let root = find(node, &mut parent);
            roots.insert(root);
        }

        let mut sizes: Vec<i32> = roots.iter().map(|&root| size[&root]).collect();
        sizes.sort_unstable();

        let n = sizes.len();
        if n == 1 {
            return sizes[0] - 1;
        }

        let sum: i32 = sizes.iter().sum();
        let max = sizes[n - 1];
        let rest = sum - max;

        if max > rest {
            rest * 2 + 1
        } else {
            sum
        }
    }
}