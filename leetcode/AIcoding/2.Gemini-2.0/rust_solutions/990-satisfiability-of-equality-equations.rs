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
        self.parent[root_x] = root_y;
    }
}

impl Solution {
    pub fn equations_possible(equations: Vec<String>) -> bool {
        let mut dsu = DSU::new(26);

        for eq in &equations {
            let chars: Vec<char> = eq.chars().collect();
            if chars[1] == '=' {
                let x = (chars[0] as u8 - b'a') as usize;
                let y = (chars[3] as u8 - b'a') as usize;
                dsu.union(x, y);
            }
        }

        for eq in &equations {
            let chars: Vec<char> = eq.chars().collect();
            if chars[1] == '!' {
                let x = (chars[0] as u8 - b'a') as usize;
                let y = (chars[3] as u8 - b'a') as usize;
                if dsu.find(x) == dsu.find(y) {
                    return false;
                }
            }
        }

        true
    }
}