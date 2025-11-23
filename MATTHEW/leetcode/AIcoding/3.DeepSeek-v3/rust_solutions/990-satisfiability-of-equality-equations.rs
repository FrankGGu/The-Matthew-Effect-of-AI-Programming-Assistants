struct UnionFind {
    parent: Vec<usize>,
}

impl UnionFind {
    fn new(size: usize) -> Self {
        UnionFind {
            parent: (0..size).collect(),
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
            self.parent[root_x] = root_y;
        }
    }
}

impl Solution {
    pub fn equations_possible(equations: Vec<String>) -> bool {
        let mut uf = UnionFind::new(26);
        let a_ord = 'a' as usize;

        for eq in &equations {
            let chars: Vec<char> = eq.chars().collect();
            if chars[1] == '=' {
                let x = chars[0] as usize - a_ord;
                let y = chars[3] as usize - a_ord;
                uf.union(x, y);
            }
        }

        for eq in &equations {
            let chars: Vec<char> = eq.chars().collect();
            if chars[1] == '!' {
                let x = chars[0] as usize - a_ord;
                let y = chars[3] as usize - a_ord;
                if uf.find(x) == uf.find(y) {
                    return false;
                }
            }
        }

        true
    }
}