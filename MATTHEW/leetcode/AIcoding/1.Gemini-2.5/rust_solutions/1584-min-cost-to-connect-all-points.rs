struct DSU {
    parent: Vec<usize>,
    size: Vec<usize>,
    num_components: usize,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
            size: vec![1; n],
            num_components: n,
        }
    }

    fn find(&mut self, i: usize) -> usize {
        if self.parent[i] == i {
            i
        } else {
            let root = self.find(self.parent[i]);
            self.parent[i] = root;
            root
        }
    }

    fn union(&mut self, i: usize, j: usize) -> bool {
        let root_i = self.find(i);
        let root_j = self.find(j);

        if root_i != root_j {
            if self.size[root_i] < self.size[root_j] {
                self.parent[root_i] = root_j;
                self.size[root_j] += self.size[root_i];
            } else {
                self.parent[root_j] = root_i;
                self.size[root_i] += self.size[root_j];
            }
            self.num_components -= 1;
            true
        } else {
            false
        }
    }
}

impl Solution {
    pub fn min_cost_connect_points(points: Vec<Vec<i32>>) -> i32 {
        let n = points.len();
        if n <= 1 {
            return 0;
        }

        let mut edges: Vec<(i32, usize, usize)> = Vec::new();

        for i in 0..n {
            for j in i + 1..n {
                let p1 = &points[i];
                let p2 = &points[j];
                let dist = (p1[0] - p2[0]).abs() + (p1[1] - p2[1]).abs();
                edges.push((dist, i, j));
            }
        }

        edges.sort_unstable_by_key(|e| e.0);

        let mut dsu = DSU::new(n);
        let mut min_cost = 0;
        let mut edges_count = 0;

        for (cost, u, v) in edges {
            if dsu.union(u, v) {
                min_cost += cost;
                edges_count += 1;
                if edges_count == n - 1 {
                    break;
                }
            }
        }

        min_cost
    }
}