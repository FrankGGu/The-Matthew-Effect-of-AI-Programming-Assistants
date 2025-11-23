impl Solution {

use std::collections::{HashMap, HashSet};

struct Solution;

impl Solution {
    pub fn find_redundant_connection(edges: Vec<Vec<i32>>) -> Vec<i32> {
        let mut parent = HashMap::new();
        let mut rank = HashMap::new();

        for i in 1..=edges.len() {
            parent.insert(i, i);
            rank.insert(i, 1);
        }

        fn find(parent: &mut HashMap<i32, i32>, x: i32) -> i32 {
            if *parent.get(&x).unwrap() != x {
                parent.insert(x, find(parent, *parent.get(&x).unwrap()));
            }
            *parent.get(&x).unwrap()
        }

        fn union(parent: &mut HashMap<i32, i32>, rank: &mut HashMap<i32, i32>, x: i32, y: i32) -> bool {
            let root_x = find(parent, x);
            let root_y = find(parent, y);
            if root_x == root_y {
                return false;
            }
            if *rank.get(&root_x).unwrap() < *rank.get(&root_y).unwrap() {
                parent.insert(root_x, root_y);
            } else {
                parent.insert(root_y, root_x);
                if *rank.get(&root_x).unwrap() == *rank.get(&root_y).unwrap() {
                    rank.insert(root_x, *rank.get(&root_x).unwrap() + 1);
                }
            }
            true
        }

        for edge in edges {
            let u = edge[0];
            let v = edge[1];
            if !union(&mut parent, &mut rank, u, v) {
                return edge;
            }
        }

        vec![]
    }
}
}