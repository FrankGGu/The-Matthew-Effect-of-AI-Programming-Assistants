struct DSU {
    parent: Vec<usize>,
    size: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
            size: vec![1; n],
        }
    }

    fn find(&mut self, i: usize) -> usize {
        if self.parent[i] == i {
            i
        } else {
            self.parent[i] = self.find(self.parent[i]);
            self.parent[i]
        }
    }

    fn union(&mut self, i: usize, j: usize) -> bool {
        let mut root_i = self.find(i);
        let mut root_j = self.find(j);

        if root_i != root_j {
            if self.size[root_i] < self.size[root_j] {
                std::mem::swap(&mut root_i, &mut root_j);
            }
            self.parent[root_j] = root_i;
            self.size[root_i] += self.size[root_j];
            true
        } else {
            false
        }
    }
}

impl Solution {
    pub fn distance_limited_paths_exist(n: i32, edge_list: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n_usize = n as usize;
        let num_queries = queries.len();

        let mut indexed_queries: Vec<(i32, i32, i32, usize)> = queries
            .into_iter()
            .enumerate()
            .map(|(i, q)| (q[0], q[1], q[2], i))
            .collect();

        indexed_queries.sort_unstable_by_key(|q| q.2);

        let mut sorted_edge_list = edge_list;
        sorted_edge_list.sort_unstable_by_key(|e| e[2]);

        let mut ans = vec![false; num_queries];
        let mut dsu = DSU::new(n_usize);
        let mut edge_idx = 0;

        for (p, q, limit, original_idx) in indexed_queries {
            while edge_idx < sorted_edge_list.len() && sorted_edge_list[edge_idx][2] < limit {
                let u = sorted_edge_list[edge_idx][0] as usize;
                let v = sorted_edge_list[edge_idx][1] as usize;
                dsu.union(u, v);
                edge_idx += 1;
            }

            if dsu.find(p as usize) == dsu.find(q as usize) {
                ans[original_idx] = true;
            }
        }

        ans
    }
}