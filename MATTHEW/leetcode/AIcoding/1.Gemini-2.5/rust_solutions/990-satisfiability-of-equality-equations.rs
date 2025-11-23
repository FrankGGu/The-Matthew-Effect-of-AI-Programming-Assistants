struct UnionFind {
    parent: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        UnionFind {
            parent: (0..n).collect(),
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
            self.parent[root_i] = root_j;
        }
    }
}

impl Solution {
    pub fn satisfy_equations(equations: Vec<String>) -> bool {
        let mut uf = UnionFind::new(26);

        for eq_str in &equations {
            let chars: Vec<char> = eq_str.chars().collect();
            let var1 = (chars[0] as u8 - b'a') as usize;
            let var2 = (chars[3] as u8 - b'a') as usize;
            let op = chars[1];

            if op == '=' {
                uf.union(var1, var2);
            }
        }

        for eq_str in &equations {
            let chars: Vec<char> = eq_str.chars().collect();
            let var1 = (chars[0] as u8 - b'a') as usize;
            let var2 = (chars[3] as u8 - b'a') as usize;
            let op = chars[1];

            if op == '!' {
                if uf.find(var1) == uf.find(var2) {
                    return false;
                }
            }
        }

        true
    }
}