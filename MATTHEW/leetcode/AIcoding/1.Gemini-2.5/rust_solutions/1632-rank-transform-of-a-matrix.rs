use std::collections::HashMap;

struct DSU {
    parent: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
        }
    }

    fn find(&mut self, i: usize) -> usize {
        if self.parent[i] == i {
            i
        } else {
            let root = self.find(self.parent[i]);
            self.parent[i] = root;
            root
        }
    }

    fn union(&mut self, i: usize, j: usize) {
        let root_i = self.find(i);
        let root_j = self.find(j);
        if root_i != root_j {
            self.parent[root_j] = root_i;
        }
    }
}

impl Solution {
    pub fn matrix_rank_transform(matrix: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let m = matrix.len();
        let n = matrix[0].len();

        let mut cells = Vec::new();
        for r in 0..m {
            for c in 0..n {
                cells.push((matrix[r][c], r, c));
            }
        }

        cells.sort_unstable_by_key(|&(val, _, _)| val);

        let mut answer = vec![vec![0; n]; m];
        let mut row_max_rank = vec![0; m];
        let mut col_max_rank = vec![0; n];

        let mut i = 0;
        while i < cells.len() {
            let mut j = i;
            while j < cells.len() && cells[j].0 == cells[i].0 {
                j += 1;
            }

            let current_group_cells: Vec<(usize, usize)> = cells[i..j]
                .iter()
                .map(|&(_, r, c)| (r, c))
                .collect();

            let num_group_cells = current_group_cells.len();
            let mut dsu = DSU::new(num_group_cells);

            let mut row_to_cell_idx: HashMap<usize, usize> = HashMap::new();
            let mut col_to_cell_idx: HashMap<usize, usize> = HashMap::new();

            for (k, &(r, c)) in current_group_cells.iter().enumerate() {
                if let Some(&prev_k) = row_to_cell_idx.get(&r) {
                    dsu.union(k, prev_k);
                } else {
                    row_to_cell_idx.insert(r, k);
                }

                if let Some(&prev_k) = col_to_cell_idx.get(&c) {
                    dsu.union(k, prev_k);
                } else {
                    col_to_cell_idx.insert(c, k);
                }
            }

            let mut component_max_prev_ranks: HashMap<usize, i32> = HashMap::new();

            for (k, &(r, c)) in current_group_cells.iter().enumerate() {
                let root = dsu.find(k);
                let current_max_prev_rank = row_max_rank[r].max(col_max_rank[c]);
                component_max_prev_ranks
                    .entry(root)
                    .and_modify(|e| *e = (*e).max(current_max_prev_rank))
                    .or_insert(current_max_prev_rank);
            }

            for (k, &(r, c)) in current_group_cells.iter().enumerate() {
                let root = dsu.find(k);
                let component_rank = 1 + component_max_prev_ranks[&root];
                answer[r][c] = component_rank;
            }

            for (k, &(r, c)) in current_group_cells.iter().enumerate() {
                let assigned_rank = answer[r][c];
                row_max_rank[r] = row_max_rank[r].max(assigned_rank);
                col_max_rank[c] = col_max_rank[c].max(assigned_rank);
            }

            i = j;
        }

        answer
    }
}