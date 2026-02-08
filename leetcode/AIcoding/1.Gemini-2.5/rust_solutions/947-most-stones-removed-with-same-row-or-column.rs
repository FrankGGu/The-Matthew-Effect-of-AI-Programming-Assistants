use std::collections::HashMap;

struct DSU {
    parent: Vec<usize>,
    num_components: usize,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
            num_components: n,
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

    fn union(&mut self, i: usize, j: usize) {
        let root_i = self.find(i);
        let root_j = self.find(j);
        if root_i != root_j {
            self.parent[root_i] = root_j;
            self.num_components -= 1;
        }
    }
}

impl Solution {
    pub fn remove_stones(stones: Vec<Vec<i32>>) -> i32 {
        let n = stones.len();
        if n <= 1 {
            return 0;
        }

        let mut dsu = DSU::new(n);
        let mut row_map: HashMap<i32, usize> = HashMap::new();
        let mut col_map: HashMap<i32, usize> = HashMap::new();

        for (i, stone) in stones.iter().enumerate() {
            let r = stone[0];
            let c = stone[1];

            if let Some(&prev_idx) = row_map.get(&r) {
                dsu.union(i, prev_idx);
            } else {
                row_map.insert(r, i);
            }

            if let Some(&prev_idx) = col_map.get(&c) {
                dsu.union(i, prev_idx);
            } else {
                col_map.insert(c, i);
            }
        }

        (n - dsu.num_components) as i32
    }
}