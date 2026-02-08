struct UnionFind {
    parent: Vec<usize>,
    rank: Vec<usize>,
}

impl UnionFind {
    fn new(size: usize) -> Self {
        UnionFind {
            parent: (0..size).collect(),
            rank: vec![0; size],
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
        if root_x == root_y {
            return;
        }
        if self.rank[root_x] < self.rank[root_y] {
            self.parent[root_x] = root_y;
        } else {
            self.parent[root_y] = root_x;
            if self.rank[root_x] == self.rank[root_y] {
                self.rank[root_x] += 1;
            }
        }
    }
}

impl Solution {
    pub fn minimum_hamming_distance(source: Vec<i32>, target: Vec<i32>, allowed_swaps: Vec<Vec<i32>>) -> i32 {
        let n = source.len();
        let mut uf = UnionFind::new(n);
        for swap in allowed_swaps {
            let x = swap[0] as usize;
            let y = swap[1] as usize;
            uf.union(x, y);
        }

        let mut groups = std::collections::HashMap::new();
        for i in 0..n {
            let root = uf.find(i);
            groups.entry(root).or_insert(vec![]).push(i);
        }

        let mut res = 0;
        for (_, indices) in groups {
            let mut freq = std::collections::HashMap::new();
            for &i in &indices {
                *freq.entry(source[i]).or_insert(0) += 1;
            }
            for &i in &indices {
                if let Some(count) = freq.get_mut(&target[i]) {
                    if *count > 0 {
                        *count -= 1;
                    } else {
                        res += 1;
                    }
                } else {
                    res += 1;
                }
            }
        }
        res
    }
}