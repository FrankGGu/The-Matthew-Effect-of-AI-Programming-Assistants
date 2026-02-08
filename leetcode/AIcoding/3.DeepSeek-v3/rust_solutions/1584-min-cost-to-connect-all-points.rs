use std::collections::BinaryHeap;
use std::cmp::Reverse;

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
        let root_x = self.find(x);
        let root_y = self.find(y);
        if root_x == root_y {
            return false;
        }
        if self.rank[root_x] < self.rank[root_y] {
            self.parent[root_x] = root_y;
        } else {
            self.parent[root_y] = root_x;
            if self.rank[root_x] == self.rank[root_y] {
                self.rank[root_x] += 1;
            }
        }
        true
    }
}

impl Solution {
    pub fn min_cost_connect_points(points: Vec<Vec<i32>>) -> i32 {
        let n = points.len();
        let mut edges = BinaryHeap::new();
        for i in 0..n {
            for j in i + 1..n {
                let cost = (points[i][0] - points[j][0]).abs() + (points[i][1] - points[j][1]).abs();
                edges.push(Reverse((cost, i, j)));
            }
        }

        let mut uf = UnionFind::new(n);
        let mut total_cost = 0;
        let mut connected = 0;

        while let Some(Reverse((cost, u, v))) = edges.pop() {
            if uf.union(u, v) {
                total_cost += cost;
                connected += 1;
                if connected == n - 1 {
                    break;
                }
            }
        }

        total_cost
    }
}