impl Solution {

use std::collections::{UnionFind, HashMap};

struct UnionFind {
    parent: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        Self {
            parent: (0..n).collect(),
        }
    }

    fn find(&mut self, x: usize) -> usize {
        if self.parent[x] != x {
            self.parent[x] = self.find(self.parent[x]);
        }
        self.parent[x]
    }

    fn union(&mut self, x: usize, y: usize) {
        let root_x = self.find(x);
        let root_y = self.find(y);
        if root_x != root_y {
            self.parent[root_y] = root_x;
        }
    }
}

impl Solution {
    pub fn smallest_string_with_swaps(s: String, pairs: Vec<Vec<i32>>) -> String {
        let n = s.len();
        let mut uf = UnionFind::new(n);
        for pair in pairs {
            let x = pair[0] as usize;
            let y = pair[1] as usize;
            uf.union(x, y);
        }

        let mut groups: HashMap<usize, Vec<char>> = HashMap::new();
        for (i, c) in s.chars().enumerate() {
            let root = uf.find(i);
            groups.entry(root).or_insert_with(Vec::new).push(c);
        }

        for (_, chars) in &mut groups {
            chars.sort();
        }

        let mut result = vec![' '; n];
        for (i, c) in s.chars().enumerate() {
            let root = uf.find(i);
            let chars = groups.get_mut(&root).unwrap();
            result[i] = chars.remove(0);
        }

        result.into_iter().collect()
    }
}
}