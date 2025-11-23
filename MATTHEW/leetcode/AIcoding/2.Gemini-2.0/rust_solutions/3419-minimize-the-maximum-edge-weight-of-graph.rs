struct DSU {
    parent: Vec<usize>,
    rank: Vec<usize>,
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

        if root_x != root_y {
            if self.rank[root_x] < self.rank[root_y] {
                self.parent[root_x] = root_y;
            } else if self.rank[root_x] > self.rank[root_y] {
                self.parent[root_y] = root_x;
            } else {
                self.parent[root_y] = root_x;
                self.rank[root_x] += 1;
            }
            return true;
        }
        false
    }
}

impl Solution {
    pub fn minimize_maximum_edge_weight(n: i32, edges: Vec<Vec<i32>>, p: i32) -> i32 {
        let n = n as usize;
        let mut edges_with_weight: Vec<(usize, usize, i32)> = edges
            .iter()
            .map(|e| (e[0] as usize - 1, e[1] as usize - 1, e[2]))
            .collect();

        edges_with_weight.sort_by_key(|&(_, _, w)| w);

        let mut left = 1;
        let mut right = 1000000000;
        let mut ans = -1;

        while left <= right {
            let mid = left + (right - left) / 2;
            let mut dsu = DSU::new(n);
            let mut count = 0;
            for &(u, v, w) in &edges_with_weight {
                if w <= mid {
                    if dsu.union(u, v) {
                        count += 1;
                    }
                }
            }

            if count >= (n - p as usize) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        ans
    }
}