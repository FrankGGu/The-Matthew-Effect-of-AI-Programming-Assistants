use std::collections::HashMap;

struct UnionFind {
    parent: Vec<usize>,
    rank: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        UnionFind {
            parent: (0..n).collect(),
            rank: vec![1; n],
        }
    }

    fn find(&mut self, u: usize) -> usize {
        if self.parent[u] != u {
            self.parent[u] = self.find(self.parent[u]);
        }
        self.parent[u]
    }

    fn union(&mut self, u: usize, v: usize) {
        let root_u = self.find(u);
        let root_v = self.find(v);
        if root_u != root_v {
            if self.rank[root_u] > self.rank[root_v] {
                self.parent[root_v] = root_u;
            } else if self.rank[root_u] < self.rank[root_v] {
                self.parent[root_u] = root_v;
            } else {
                self.parent[root_v] = root_u;
                self.rank[root_u] += 1;
            }
        }
    }
}

pub fn distance_limited_paths_exist(n: i32, edge_list: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<bool> {
    let mut edges: Vec<(i32, i32, i32)> = edge_list.into_iter().map(|e| (e[2], e[0], e[1])).collect();
    edges.sort();

    let mut indexed_queries: Vec<(i32, i32, usize)> = queries.into_iter().enumerate().map(|(i, q)| (q[2], q[0], q[1], i)).collect();
    indexed_queries.sort();

    let mut uf = UnionFind::new(n as usize);
    let mut result = vec![false; indexed_queries.len()];
    let mut edge_index = 0;

    for (limit, u, v, query_index) in indexed_queries {
        while edge_index < edges.len() && edges[edge_index].0 < limit {
            uf.union(edges[edge_index].1 as usize, edges[edge_index].2 as usize);
            edge_index += 1;
        }
        result[query_index] = uf.find(u as usize) == uf.find(v as usize);
    }

    result
}