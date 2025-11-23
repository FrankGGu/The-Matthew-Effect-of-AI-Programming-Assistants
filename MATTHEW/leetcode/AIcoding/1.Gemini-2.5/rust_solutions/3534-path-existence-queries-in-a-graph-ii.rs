struct DSU {
    parent: Vec<usize>,
    rank: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
            rank: vec![1; n],
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
        let root_i = self.find(i);
        let root_j = self.find(j);

        if root_i != root_j {
            if self.rank[root_i] < self.rank[root_j] {
                self.parent[root_i] = root_j;
            } else if self.rank[root_i] > self.rank[root_j] {
                self.parent[root_j] = root_i;
            } else {
                self.parent[root_j] = root_i;
                self.rank[root_i] += 1;
            }
            true
        } else {
            false
        }
    }
}

impl Solution {
    pub fn distance_limited_paths_exist(n: i32, edges: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = n as usize;
        let mut dsu = DSU::new(n);

        let mut sorted_edges: Vec<(i32, i32, i32)> = edges
            .into_iter()
            .map(|e| (e[0], e[1], e[2]))
            .collect();
        sorted_edges.sort_unstable_by_key(|&(_, _, w)| w);

        let mut sorted_queries: Vec<(i32, i32, i32, usize)> = queries
            .into_iter()
            .enumerate()
            .map(|(i, q)| (q[0], q[1], q[2], i))
            .collect();
        sorted_queries.sort_unstable_by_key(|&(_, _, limit, _)| limit);

        let mut answers = vec![false; sorted_queries.len()];
        let mut edge_idx = 0;

        for (p, q, limit, original_idx) in sorted_queries {
            while edge_idx < sorted_edges.len() && sorted_edges[edge_idx].2 < limit {
                dsu.union(sorted_edges[edge_idx].0 as usize, sorted_edges[edge_idx].1 as usize);
                edge_idx += 1;
            }
            answers[original_idx] = dsu.find(p as usize) == dsu.find(q as usize);
        }

        answers
    }
}