struct DSU {
    parent: Vec<usize>,
    rank: Vec<usize>,
    count: usize,
}

impl DSU {
    fn new(n: usize) -> Self {
        let mut parent = vec![0; n];
        for i in 0..n {
            parent[i] = i;
        }
        DSU {
            parent,
            rank: vec![0; n],
            count: n,
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
            if self.rank[root_x] < self.rank[root_y] {
                self.parent[root_x] = root_y;
            } else if self.rank[root_x] > self.rank[root_y] {
                self.parent[root_y] = root_x;
            } else {
                self.parent[root_y] = root_x;
                self.rank[root_x] += 1;
            }
            self.count -= 1;
        }
    }

    fn get_count(&self) -> usize {
        self.count
    }
}

impl Solution {
    pub fn make_connected(n: i32, connections: Vec<Vec<i32>>) -> i32 {
        let n = n as usize;
        let mut dsu = DSU::new(n);
        let mut extra_edges = 0;

        for connection in &connections {
            let u = connection[0] as usize;
            let v = connection[1] as usize;
            if dsu.find(u) == dsu.find(v) {
                extra_edges += 1;
            } else {
                dsu.union(u, v);
            }
        }

        let components = dsu.get_count();
        let needed_edges = components - 1;

        if extra_edges as usize >= needed_edges {
            needed_edges as i32
        } else {
            -1
        }
    }
}