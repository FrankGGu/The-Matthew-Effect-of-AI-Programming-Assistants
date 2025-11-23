use std::collections::HashMap;

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
    pub fn number_of_good_paths(values: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        let n = values.len();
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut nodes_with_values: Vec<(i32, usize)> = (0..n).map(|i| (values[i], i)).collect();
        nodes_with_values.sort_unstable();

        let mut dsu = DSU::new(n);
        let mut ans = n as i32;

        let mut i = 0;
        while i < n {
            let current_val = nodes_with_values[i].0;
            let mut j = i;
            while j < n && nodes_with_values[j].0 == current_val {
                let u = nodes_with_values[j].1;
                for &v in &adj[u] {
                    if values[v] <= current_val {
                        dsu.union(u, v);
                    }
                }
                j += 1;
            }

            let mut component_val_counts: HashMap<usize, i32> = HashMap::new();
            let mut k = i;
            while k < n && nodes_with_values[k].0 == current_val {
                let u = nodes_with_values[k].1;
                let root_u = dsu.find(u);
                *component_val_counts.entry(root_u).or_insert(0) += 1;
                k += 1;
            }

            for (_root, count) in component_val_counts {
                ans += count * (count - 1) / 2;
            }

            i = j;
        }

        ans
    }
}