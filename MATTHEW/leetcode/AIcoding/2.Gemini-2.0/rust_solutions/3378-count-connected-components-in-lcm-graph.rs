struct DSU {
    parent: Vec<usize>,
    size: Vec<usize>,
    count: usize,
}

impl DSU {
    fn new(n: usize) -> Self {
        let mut parent = vec![0; n];
        let mut size = vec![1; n];
        for i in 0..n {
            parent[i] = i;
        }
        DSU {
            parent,
            size,
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
            if self.size[root_x] < self.size[root_y] {
                self.parent[root_x] = root_y;
                self.size[root_y] += self.size[root_x];
            } else {
                self.parent[root_y] = root_x;
                self.size[root_x] += self.size[root_y];
            }
            self.count -= 1;
        }
    }
}

impl Solution {
    pub fn count_connected_components(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let mut dsu = DSU::new(n as usize);
        for edge in edges {
            dsu.union(edge[0] as usize, edge[1] as usize);
        }
        dsu.count as i32
    }

    pub fn count_connected_components_lcm(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let mut dsu = DSU::new(n as usize + 1);

        for i in 1..=n as usize {
            for j in (i * 2..=n as usize).step_by(i) {
                if Self::lcm(i as i64, j as i64) <= n as i64 {
                    dsu.union(i, j);
                }
            }
        }

        edges.iter().for_each(|edge|{
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            dsu.union(u, v);
        });

        let mut count = 0;
        for i in 1..=n as usize {
            if dsu.find(i) == i {
                count += 1;
            }
        }

        count
    }

    fn gcd(a: i64, b: i64) -> i64 {
        if b == 0 {
            a
        } else {
            Self::gcd(b, a % b)
        }
    }

    fn lcm(a: i64, b: i64) -> i64 {
        a * b / Self::gcd(a, b)
    }
}