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

    fn union(&mut self, i: usize, j: usize) {
        let root_i = self.find(i);
        let root_j = self.find(j);
        if root_i != root_j {
            self.parent[root_j] = root_i;
            self.count -= 1;
        }
    }
}

impl Solution {
    fn is_similar(s1: &str, s2: &str) -> bool {
        let mut diff_count = 0;
        let mut diff_chars_s1 = Vec::new();
        let mut diff_chars_s2 = Vec::new();

        for (c1, c2) in s1.chars().zip(s2.chars()) {
            if c1 != c2 {
                diff_count += 1;
                diff_chars_s1.push(c1);
                diff_chars_s2.push(c2);
            }
        }

        if diff_count == 0 {
            true
        } else if diff_count == 2 {
            diff_chars_s1[0] == diff_chars_s2[1] && diff_chars_s1[1] == diff_chars_s2[0]
        } else {
            false
        }
    }

    pub fn num_similar_groups(strs: Vec<String>) -> i32 {
        let n = strs.len();
        let mut dsu = DSU::new(n);

        for i in 0..n {
            for j in (i + 1)..n {
                if Self::is_similar(&strs[i], &strs[j]) {
                    dsu.union(i, j);
                }
            }
        }

        dsu.count as i32
    }
}