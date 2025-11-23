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
        if self.parent[x] == x {
            return x;
        }
        self.parent[x] = self.find(self.parent[x]);
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
    pub fn are_connected(n: i32, threshold: i32, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = n as usize;
        let threshold = threshold as i32;
        let mut dsu = DSU::new(n + 1);

        for i in (threshold + 1) as i32..=(n as i32 / 2) as i32 {
            for j in 2.. {
                let a = i * j;
                if a > n as i32 {
                    break;
                }
                dsu.union(i as usize, a as usize);
            }
        }

        let mut result = Vec::new();
        for query in queries {
            let a = query[0] as usize;
            let b = query[1] as usize;
            result.push(dsu.find(a) == dsu.find(b));
        }

        result
    }
}