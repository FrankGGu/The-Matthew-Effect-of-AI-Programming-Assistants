struct UnionFind {
    parent: Vec<usize>,
    size: Vec<usize>,
}

impl UnionFind {
    fn new(n: usize) -> Self {
        let parent = (0..n).collect();
        let size = vec![1; n];
        UnionFind { parent, size }
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
        if self.size[root_x] < self.size[root_y] {
            self.parent[root_x] = root_y;
            self.size[root_y] += self.size[root_x];
        } else {
            self.parent[root_y] = root_x;
            self.size[root_x] += self.size[root_y];
        }
    }
}

struct DistanceLimitedPathsExist {
    uf: UnionFind,
    edges: Vec<(usize, usize, i32)>,
    max_queries: Vec<(i32, usize, usize, usize)>,
    answers: Vec<bool>,
}

impl DistanceLimitedPathsExist {
    fn new(n: i32, edge_list: Vec<Vec<i32>>) -> Self {
        let n = n as usize;
        let mut edges = Vec::with_capacity(edge_list.len());
        for edge in edge_list {
            edges.push((edge[0] as usize, edge[1] as usize, edge[2]));
        }
        edges.sort_unstable_by_key(|&(_, _, d)| d);
        DistanceLimitedPathsExist {
            uf: UnionFind::new(n),
            edges,
            max_queries: Vec::new(),
            answers: Vec::new(),
        }
    }

    fn query(&mut self, p: i32, q: i32, limit: i32) -> bool {
        let p = p as usize;
        let q = q as usize;
        let limit = limit;
        let idx = self.max_queries.len();
        self.max_queries.push((limit, p, q, idx));
        self.answers.push(false);
        false
    }

    fn process_queries(&mut self) {
        self.max_queries.sort_unstable_by_key(|&(d, _, _, _)| d);
        let mut edge_ptr = 0;
        for &(limit, p, q, idx) in &self.max_queries {
            while edge_ptr < self.edges.len() && self.edges[edge_ptr].2 < limit {
                let (u, v, _) = self.edges[edge_ptr];
                self.uf.union(u, v);
                edge_ptr += 1;
            }
            self.answers[idx] = self.uf.find(p) == self.uf.find(q);
        }
    }
}