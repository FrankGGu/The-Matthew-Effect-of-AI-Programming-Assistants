struct DSU {
    parent: Vec<i32>,
    count: i32,
}

impl DSU {
    fn new(n: i32) -> Self {
        DSU {
            parent: (0..n).collect(),
            count: n,
        }
    }

    fn find(&mut self, i: i32) -> i32 {
        if self.parent[i as usize] == i {
            i
        } else {
            let root = self.find(self.parent[i as usize]);
            self.parent[i as usize] = root;
            root
        }
    }

    fn union(&mut self, i: i32, j: i32) -> bool {
        let root_i = self.find(i);
        let root_j = self.find(j);
        if root_i != root_j {
            self.parent[root_i as usize] = root_j;
            self.count -= 1;
            true
        } else {
            false
        }
    }
}

impl Solution {
    pub fn find_critical_and_pseudo_critical_edges(n: i32, edges: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let mut indexed_edges: Vec<(i32, i32, i32, i32)> = edges
            .into_iter()
            .enumerate()
            .map(|(i, edge)| (edge[2], edge[0], edge[1], i as i32))
            .collect();

        indexed_edges.sort_unstable();

        let (base_mst_weight, _) = Self::kruskal(n, &indexed_edges, -1, None);

        let mut critical_edges = Vec::new();
        let mut pseudo_critical_edges = Vec::new();

        for i in 0..indexed_edges.len() {
            let current_edge_tuple = indexed_edges[i];
            let original_idx = current_edge_tuple.3;

            let (mst_weight_exclude, mst_count_exclude) = Self::kruskal(n, &indexed_edges, original_idx, None);
            if mst_count_exclude != n - 1 || mst_weight_exclude > base_mst_weight {
                critical_edges.push(original_idx);
                continue;
            }

            let (mst_weight_include, mst_count_include) = Self::kruskal(n, &indexed_edges, -1, Some(&current_edge_tuple));
            if mst_count_include == n - 1 && mst_weight_include == base_mst_weight {
                pseudo_critical_edges.push(original_idx);
            }
        }

        vec![critical_edges, pseudo_critical_edges]
    }

    fn kruskal(n: i32, edges: &Vec<(i32, i32, i32, i32)>, exclude_idx: i32, include_edge: Option<&(i32, i32, i32, i32)>) -> (i32, i32) {
        let mut dsu = DSU::new(n);
        let mut current_mst_weight = 0;
        let mut edges_in_mst = 0;

        if let Some(&(w, u, v, _)) = include_edge {
            dsu.union(u, v);
            current_mst_weight += w;
            edges_in_mst += 1;
        }

        for &(w, u, v, idx) in edges {
            if idx == exclude_idx {
                continue;
            }
            if let Some(&(_, _, _, included_idx)) = include_edge {
                if idx == included_idx {
                    continue;
                }
            }

            if dsu.union(u, v) {
                current_mst_weight += w;
                edges_in_mst += 1;
            }
        }

        if edges_in_mst == n - 1 {
            (current_mst_weight, edges_in_mst)
        } else {
            (std::i32::MAX, edges_in_mst)
        }
    }
}