struct DSU {
    parent: Vec<usize>,
    size: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        let mut parent = vec![0; n];
        let mut size = vec![1; n];
        for i in 0..n {
            parent[i] = i;
        }
        DSU { parent, size }
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
        }
    }
}

impl Solution {
    pub fn distance_limited_paths_exist(n: i32, edge_list: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<bool> {
        let n = n as usize;
        let mut edge_list = edge_list;
        edge_list.sort_by_key(|edge| edge[2]);

        let mut queries_with_index: Vec<(usize, Vec<i32>)> = queries.into_iter().enumerate().collect();
        queries_with_index.sort_by_key(|(_, query)| query[2]);

        let mut dsu = DSU::new(n);
        let mut results = vec![false; queries_with_index.len()];
        let mut edge_index = 0;

        for (query_index, query) in queries_with_index {
            let limit = query[2] as i32;
            while edge_index < edge_list.len() && edge_list[edge_index][2] < limit {
                let u = edge_list[edge_index][0] as usize;
                let v = edge_list[edge_index][1] as usize;
                dsu.union(u, v);
                edge_index += 1;
            }

            let u = query[0] as usize;
            let v = query[1] as usize;
            results[query_index] = dsu.find(u) == dsu.find(v);
        }

        results
    }
}