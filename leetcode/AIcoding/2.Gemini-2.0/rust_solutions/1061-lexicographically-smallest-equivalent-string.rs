struct DSU {
    parent: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
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
            if root_x < root_y {
                self.parent[root_y] = root_x;
            } else {
                self.parent[root_x] = root_y;
            }
        }
    }
}

impl Solution {
    pub fn smallest_equivalent_string(s1: String, s2: String, base_str: String) -> String {
        let mut dsu = DSU::new(26);
        let s1_bytes = s1.as_bytes();
        let s2_bytes = s2.as_bytes();

        for i in 0..s1_bytes.len() {
            let c1 = (s1_bytes[i] - b'a') as usize;
            let c2 = (s2_bytes[i] - b'a') as usize;
            dsu.union(c1, c2);
        }

        let base_bytes = base_str.as_bytes();
        let mut result = String::new();

        for &c in base_bytes {
            let idx = (c - b'a') as usize;
            let root = dsu.find(idx);
            result.push((root as u8 + b'a') as char);
        }

        result
    }
}