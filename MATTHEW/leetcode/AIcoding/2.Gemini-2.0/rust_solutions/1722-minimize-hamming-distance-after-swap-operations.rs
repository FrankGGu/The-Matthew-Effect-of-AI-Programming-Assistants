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
        if self.parent[i] != i {
            self.parent[i] = self.find(self.parent[i]);
        }
        self.parent[i]
    }

    fn union(&mut self, i: usize, j: usize) {
        let root_i = self.find(i);
        let root_j = self.find(j);
        if root_i != root_j {
            self.parent[root_i] = root_j;
        }
    }
}

impl Solution {
    pub fn min_hamming_distance(mut source: Vec<i32>, target: Vec<i32>, allowed_swaps: Vec<Vec<i32>>) -> i32 {
        let n = source.len();
        let mut dsu = DSU::new(n);

        for swap in allowed_swaps {
            dsu.union(swap[0] as usize, swap[1] as usize);
        }

        let mut groups: std::collections::HashMap<usize, Vec<usize>> = std::collections::HashMap::new();
        for i in 0..n {
            let root = dsu.find(i);
            groups.entry(root).or_insert(Vec::new()).push(i);
        }

        let mut hamming_distance = 0;
        for (_, indices) in groups {
            let mut source_vals: Vec<i32> = indices.iter().map(|&i| source[i]).collect();
            let mut target_vals: Vec<i32> = indices.iter().map(|&i| target[i]).collect();
            source_vals.sort();
            target_vals.sort();

            let mut i = 0;
            let mut j = 0;
            while i < source_vals.len() && j < target_vals.len() {
                if source_vals[i] == target_vals[j] {
                    i += 1;
                    j += 1;
                } else if source_vals[i] < target_vals[j] {
                    i += 1;
                    hamming_distance += 1;
                } else {
                    j += 1;
                    hamming_distance += 1;
                }
            }

            while i < source_vals.len() {
                hamming_distance += 1;
                i += 1;
            }

            while j < target_vals.len() {
                hamming_distance += 1;
                j += 1;
            }
            hamming_distance /= 2;

        }

        hamming_distance
    }
}