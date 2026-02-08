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

    fn union(&mut self, x: usize, y: usize) -> bool {
        let x_root = self.find(x);
        let y_root = self.find(y);
        if x_root == y_root {
            return false;
        }
        if self.rank[x_root] < self.rank[y_root] {
            self.parent[x_root] = y_root;
        } else {
            self.parent[y_root] = x_root;
            if self.rank[x_root] == self.rank[y_root] {
                self.rank[x_root] += 1;
            }
        }
        true
    }
}

impl Solution {
    pub fn friend_requests(n: i32, restrictions: Vec<Vec<i32>>, requests: Vec<Vec<i32>>) -> Vec<bool> {
        let n = n as usize;
        let mut uf = UnionFind::new(n);
        let mut res = Vec::with_capacity(requests.len());
        for request in requests {
            let u = request[0] as usize;
            let v = request[1] as usize;
            let u_root = uf.find(u);
            let v_root = uf.find(v);
            let mut valid = true;
            for restriction in &restrictions {
                let x = restriction[0] as usize;
                let y = restriction[1] as usize;
                let x_root = uf.find(x);
                let y_root = uf.find(y);
                if (x_root == u_root && y_root == v_root) || (x_root == v_root && y_root == u_root) {
                    valid = false;
                    break;
                }
            }
            res.push(valid);
            if valid {
                uf.union(u, v);
            }
        }
        res
    }
}