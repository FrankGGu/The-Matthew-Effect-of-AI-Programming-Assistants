struct UnionFind {
    parent: Vec<usize>,
    rank: Vec<usize>,
}

impl UnionFind {
    fn new(size: usize) -> Self {
        let parent = (0..size).collect();
        let rank = vec![0; size];
        UnionFind { parent, rank }
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
        if root_x == root_y {
            return;
        }
        if self.rank[root_x] < self.rank[root_y] {
            self.parent[root_x] = root_y;
        } else {
            self.parent[root_y] = root_x;
            if self.rank[root_x] == self.rank[root_y] {
                self.rank[root_x] += 1;
            }
        }
    }
}

impl Solution {
    pub fn distance_limited_paths_exist(n: i32, edge_list: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = n as usize;
        let mut edge_list = edge_list;
        let mut queries_with_index: Vec<(usize, usize, usize, i32)> = queries
            .iter()
            .enumerate()
            .map(|(i, q)| (q[0] as usize, q[1] as usize, i, q[2]))
            .collect();

        edge_list.sort_by(|a, b| a[2].cmp(&b[2]));
        queries_with_index.sort_by(|a, b| a.3.cmp(&b.3));

        let mut uf = UnionFind::new(n);
        let mut result = vec![false; queries.len()];
        let mut edge_idx = 0;

        for (u, v, idx, limit) in queries_with_index {
            while edge_idx < edge_list.len() && edge_list[edge_idx][2] < limit {
                let edge = &edge_list[edge_idx];
                uf.union(edge[0] as usize, edge[1] as usize);
                edge_idx += 1;
            }
            result[idx] = uf.find(u) == uf.find(v);
        }

        result
    }
}