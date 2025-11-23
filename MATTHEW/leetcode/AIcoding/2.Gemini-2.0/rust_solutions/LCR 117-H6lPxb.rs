struct UnionFind {
    parent: Vec<usize>,
    size: Vec<usize>,
    count: usize,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        let parent: Vec<usize> = (0..n).collect();
        let size = vec![1; n];
        UnionFind {
            parent,
            size,
            count: n,
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
            if self.size[root_x] < self.size[root_y] {
                self.parent[root_x] = root_y;
                self.size[root_y] += self.size[root_x];
            } else {
                self.parent[root_y] = root_x;
                self.size[root_x] += self.size[root_y];
            }
            self.count -= 1;
        }
    }

    fn count(&self) -> usize {
        self.count
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

        uf.count() as i32
    }

    fn is_similar(s1: &str, s2: &str) -> bool {
        let mut diff = 0;
        let s1_chars: Vec<char> = s1.chars().collect();
        let s2_chars: Vec<char> = s2.chars().collect();

        for i in 0..s1.len() {
            if s1_chars[i] != s2_chars[i] {
                diff += 1;
            }
        }

        diff <= 2
    }
}