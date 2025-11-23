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
    pub fn num_similar_groups(strs: Vec<String>) -> i32 {
        let n = strs.len();
        let mut uf = UnionFind::new(n);
        for i in 0..n {
            for j in i + 1..n {
                if Self::is_similar(&strs[i], &strs[j]) {
                    uf.union(i, j);
                }
            }
        }
        let mut groups = 0;
        for i in 0..n {
            if uf.find(i) == i {
                groups += 1;
            }
        }
        groups
    }

    fn is_similar(a: &str, b: &str) -> bool {
        let a_chars: Vec<char> = a.chars().collect();
        let b_chars: Vec<char> = b.chars().collect();
        let mut diff = 0;
        for i in 0..a_chars.len() {
            if a_chars[i] != b_chars[i] {
                diff += 1;
                if diff > 2 {
                    return false;
                }
            }
        }
        true
    }
}