impl Solution {

use std::collections::{HashMap, HashSet};

struct Solution;

impl Solution {
    pub fn find_redundant_connection(edges: Vec<Vec<i32>>) -> Vec<i32> {
        let mut parent = HashMap::new();

        fn find(p: &mut HashMap<i32, i32>, x: i32) -> i32 {
            if *p.get(&x).unwrap() != x {
                p.insert(x, find(p, *p.get(&x).unwrap()));
            }
            *p.get(&x).unwrap()
        }

        fn union(p: &mut HashMap<i32, i32>, x: i32, y: i32) -> bool {
            let root_x = find(p, x);
            let root_y = find(p, y);
            if root_x == root_y {
                return false;
            }
            p.insert(root_y, root_x);
            true
        }

        for edge in edges {
            let u = edge[0];
            let v = edge[1];
            if !parent.contains_key(&u) {
                parent.insert(u, u);
            }
            if !parent.contains_key(&v) {
                parent.insert(v, v);
            }
            if !union(&mut parent, u, v) {
                return edge;
            }
        }

        vec![]
    }
}
}