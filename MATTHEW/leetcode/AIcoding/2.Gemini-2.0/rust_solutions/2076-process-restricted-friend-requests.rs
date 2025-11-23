struct DSU {
    parent: Vec<usize>,
    rank: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
            rank: vec![0; n],
        }
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

        if root_x == root_y {
            return false;
        }

        if self.rank[root_x] < self.rank[root_y] {
            self.parent[root_x] = root_y;
        } else if self.rank[root_x] > self.rank[root_y] {
            self.parent[root_y] = root_x;
        } else {
            self.parent[root_y] = root_x;
            self.rank[root_x] += 1;
        }
        true
    }
}

impl Solution {
    pub fn friend_requests(n: i32, restrictions: Vec<Vec<i32>>, requests: Vec<Vec<i32>>) -> Vec<bool> {
        let n = n as usize;
        let mut dsu = DSU::new(n);
        let mut result = Vec::with_capacity(requests.len());

        for request in &requests {
            let u = request[0] as usize;
            let v = request[1] as usize;
            let root_u = dsu.find(u);
            let root_v = dsu.find(v);

            let mut can_connect = true;
            for restriction in &restrictions {
                let a = restriction[0] as usize;
                let b = restriction[1] as usize;

                let root_a = dsu.find(a);
                let root_b = dsu.find(b);

                if (root_a == root_u && root_b == root_v) || (root_a == root_v && root_b == root_u) {
                    can_connect = false;
                    break;
                }
            }

            if can_connect {
                dsu.union(u, v);
                result.push(true);
            } else {
                result.push(false);
            }
        }

        result
    }
}