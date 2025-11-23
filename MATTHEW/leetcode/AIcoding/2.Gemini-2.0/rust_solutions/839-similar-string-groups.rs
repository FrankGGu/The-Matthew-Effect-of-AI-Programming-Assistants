struct DSU {
    parent: Vec<usize>,
    size: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        let mut parent = vec![0; n];
        let mut size = vec![1; n];
        for i in 0..n {
            parent[i] = i;
        }
        DSU { parent, size }
    }

    fn find(&mut self, x: usize) -> usize {
        if self.parent[x] != x {
            self.parent[x] = self.find(self.parent[x]);
        }
        self.parent[x]
    }

    fn union(&mut self, x: usize, y: usize) -> bool {
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
            true
        } else {
            false
        }
    }
}

impl Solution {
    pub fn num_similar_groups(strs: Vec<String>) -> i32 {
        fn is_similar(s1: &String, s2: &String) -> bool {
            let mut diff = 0;
            for (c1, c2) in s1.chars().zip(s2.chars()) {
                if c1 != c2 {
                    diff += 1;
                }
            }
            diff <= 2
        }

        let n = strs.len();
        let mut dsu = DSU::new(n);
        let mut count = n;

        for i in 0..n {
            for j in i + 1..n {
                if is_similar(&strs[i], &strs[j]) {
                    if dsu.union(i, j) {
                        count -= 1;
                    }
                }
            }
        }

        count as i32
    }
}