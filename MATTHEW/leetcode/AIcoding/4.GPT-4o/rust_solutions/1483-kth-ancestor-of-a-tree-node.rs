use std::collections::HashMap;

struct TreeAncestor {
    parent: Vec<Vec<i32>>,
}

impl TreeAncestor {
    fn new(n: i32, parent: Vec<i32>) -> Self {
        let mut ancestor = vec![vec![-1; 20]; n as usize];
        for i in 0..n {
            ancestor[i as usize][0] = parent[i as usize];
        }
        for j in 1..20 {
            for i in 0..n {
                if ancestor[i as usize][j - 1] != -1 {
                    ancestor[i as usize][j] = ancestor[ancestor[i as usize][j - 1] as usize][j - 1];
                }
            }
        }
        TreeAncestor { parent: ancestor }
    }

    fn get_kth_ancestor(&self, node: i32, k: i32) -> i32 {
        let mut current = node;
        let mut step = k;
        while step > 0 && current != -1 {
            let idx = (step as usize).trailing_zeros() as usize;
            current = self.parent[current as usize][idx] as i32;
            step -= 1 << idx;
        }
        current
    }
}