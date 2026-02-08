use std::collections::{HashMap, HashSet};

impl Solution {
    pub fn check_ways(pairs: Vec<Vec<i32>>) -> i32 {
        let mut adj: HashMap<i32, HashSet<i32>> = HashMap::new();
        for pair in &pairs {
            let u = pair[0];
            let v = pair[1];
            adj.entry(u).or_insert_with(HashSet::new).insert(v);
            adj.entry(v).or_insert_with(HashSet::new).insert(u);
        }

        let mut nodes: Vec<i32> = adj.keys().cloned().collect();
        nodes.sort_by(|a, b| adj.get(b).unwrap().len().cmp(&adj.get(a).unwrap().len()));

        let n = nodes.len();
        let mut parent: HashMap<i32, i32> = HashMap::new();
        let mut root = -1;
        let mut res = 1;

        for &u in &nodes {
            parent.insert(u, -1);
            for &v in &nodes {
                if v == u {
                    break;
                }
                if adj.get(&u).unwrap().contains(&v) {
                    parent.insert(u, v);
                    break;
                }
            }
            let p = *parent.get(&u).unwrap();
            if p == -1 {
                if root != -1 {
                    return 0;
                }
                root = u;
                continue;
            }
            if !adj.get(&p).unwrap().contains(&u) {
                return 0;
            }
            for &v in adj.get(&u).unwrap() {
                if v != p && !adj.get(&p).unwrap().contains(&v) {
                    return 0;
                }
            }
            if adj.get(&u).unwrap().len() == adj.get(&p).unwrap().len() {
                res = 2;
            }
        }
        res
    }
}