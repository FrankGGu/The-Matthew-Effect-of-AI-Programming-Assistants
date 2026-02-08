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
        let x_root = self.find(x);
        let y_root = self.find(y);
        if x_root == y_root {
            return false;
        }
        if self.rank[x_root] < self.rank[y_root] {
            self.parent[x_root] = y_root;
        } else {
            self.parent[y_root] = x_root;
            if self.rank[x_root] == self.rank[y_root] {
                self.rank[x_root] += 1;
            }
        }
        true
    }
}

impl Solution {
    pub fn find_critical_and_pseudo_critical_edges(n: i32, edges: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n = n as usize;
        let m = edges.len();
        let mut edges_with_index: Vec<(usize, usize, usize, usize)> = edges
            .iter()
            .enumerate()
            .map(|(i, e)| (e[0] as usize, e[1] as usize, e[2] as usize, i))
            .collect();
        edges_with_index.sort_by_key(|&(_, _, w, _)| w);

        let mst_weight = Self::kruskal(n, &edges_with_index, None, None);

        let mut critical = Vec::new();
        let mut pseudo = Vec::new();

        for i in 0..m {
            let weight_without = Self::kruskal(n, &edges_with_index, Some(i), None);
            if weight_without > mst_weight {
                critical.push(i as i32);
                continue;
            }

            let forced_edge = edges_with_index.iter().position(|&(_, _, _, idx)| idx == i).unwrap();
            let weight_with = Self::kruskal(n, &edges_with_index, None, Some(forced_edge));
            if weight_with == mst_weight {
                pseudo.push(i as i32);
            }
        }

        vec![critical, pseudo]
    }

    fn kruskal(
        n: usize,
        edges: &[(usize, usize, usize, usize)],
        skip: Option<usize>,
        force: Option<usize>,
    ) -> usize {
        let mut uf = UnionFind::new(n);
        let mut weight = 0;
        let mut count = 0;

        if let Some(i) = force {
            let (u, v, w, _) = edges[i];
            if uf.union(u, v) {
                weight += w;
                count += 1;
            }
        }

        for (idx, &(u, v, w, _)) in edges.iter().enumerate() {
            if Some(idx) == skip {
                continue;
            }
            if uf.union(u, v) {
                weight += w;
                count += 1;
            }
            if count == n - 1 {
                break;
            }
        }

        if count == n - 1 {
            weight
        } else {
            usize::MAX
        }
    }
}