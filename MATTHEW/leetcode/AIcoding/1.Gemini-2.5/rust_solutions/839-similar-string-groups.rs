struct DSU {
    parent: Vec<usize>,
    count: usize,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
            count: n,
        }
    }

    fn find(&mut self, i: usize) -> usize {
        if self.parent[i] == i {
            i
        } else {
            self.parent[i] = self.find(self.parent[i]);
            self.parent[i]
        }
    }

    fn union(&mut self, i: usize, j: usize) -> bool {
        let root_i = self.find(i);
        let root_j = self.find(j);

        if root_i != root_j {
            self.parent[root_i] = root_j;
            self.count -= 1;
            true
        } else {
            false
        }
    }

    fn get_count(&self) -> i32 {
        self.count as i32
    }
}

impl Solution {
    fn is_similar(s1: &str, s2: &str) -> bool {
        let mut diff_count = 0;
        for (c1, c2) in s1.chars().zip(s2.chars()) {
            if c1 != c2 {
                diff_count += 1;
            }
            if diff_count > 2 {
                return false;
            }
        }
        diff_count == 0 || diff_count == 2
    }

    pub fn num_similar_groups(strs: Vec<String>) -> i32 {
        let n = strs.len();
        if n <= 1 {
            return n as i32;
        }

        let mut dsu = DSU::new(n);

        for i in 0..n {
            for j in (i + 1)..n {
                if Solution::is_similar(&strs[i], &strs[j]) {
                    dsu.union(i, j);
                }
            }
        }

        dsu.get_count()
    }
}