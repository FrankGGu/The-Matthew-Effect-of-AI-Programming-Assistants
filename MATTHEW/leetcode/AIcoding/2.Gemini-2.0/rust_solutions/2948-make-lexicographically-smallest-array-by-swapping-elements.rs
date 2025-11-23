struct DSU {
    parent: Vec<usize>,
}

impl DSU {
    fn new(n: usize) -> Self {
        DSU {
            parent: (0..n).collect(),
        }
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
            self.parent[root_x] = root_y;
        }
    }
}

impl Solution {
    pub fn smallest_lexical_order(nums: Vec<i32>, allowed_swaps: Vec<Vec<i32>>) -> Vec<i32> {
        let n = nums.len();
        let mut dsu = DSU::new(n);

        for swap in allowed_swaps {
            dsu.union(swap[0] as usize, swap[1] as usize);
        }

        let mut components: std::collections::HashMap<usize, Vec<usize>> = std::collections::HashMap::new();
        for i in 0..n {
            let root = dsu.find(i);
            components.entry(root).or_insert(Vec::new()).push(i);
        }

        let mut result = nums.clone();
        for (_, indices) in components {
            let mut values: Vec<i32> = indices.iter().map(|&i| nums[i]).collect();
            indices.sort();
            values.sort();
            for i in 0..indices.len() {
                result[indices[i]] = values[i];
            }
        }

        result
    }
}