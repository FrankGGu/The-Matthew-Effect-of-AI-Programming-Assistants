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
    pub fn minimize_hamming_distance(source: Vec<i32>, target: Vec<i32>, allowed_swaps: Vec<Vec<i32>>) -> i32 {
        let n = source.len();
        let mut dsu = DSU::new(n);

        for swap in allowed_swaps {
            dsu.union(swap[0] as usize, swap[1] as usize);
        }

        let mut components: HashMap<usize, Vec<usize>> = HashMap::new();
        for i in 0..n {
            let root = dsu.find(i);
            components.entry(root).or_insert_with(Vec::new).push(i);
        }

        let mut total_hamming_distance = 0;

        for (_root, indices) in components {
            let mut source_counts: HashMap<i32, i32> = HashMap::new();
            let mut target_counts: HashMap<i32, i32> = HashMap::new();

            for &idx in &indices {
                *source_counts.entry(source[idx]).or_insert(0) += 1;
                *target_counts.entry(target[idx]).or_insert(0) += 1;
            }

            let mut matched_elements_in_component = 0;
            for (val, &s_count) in &source_counts {
                if let Some(&t_count) = target_counts.get(val) {
                    matched_elements_in_component += s_count.min(t_count);
                }
            }

            total_hamming_distance += (indices.len() as i32) - matched_elements_in_component;
        }

        total_hamming_distance
    }
}