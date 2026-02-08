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
    pub fn smallest_string_with_swaps(s: String, pairs: Vec<Vec<i32>>) -> String {
        let n = s.len();
        let mut dsu = DSU::new(n);

        for pair in &pairs {
            dsu.union(pair[0] as usize, pair[1] as usize);
        }

        let mut components: HashMap<usize, Vec<usize>> = HashMap::new();
        for i in 0..n {
            let root = dsu.find(i);
            components.entry(root).or_insert(Vec::new()).push(i);
        }

        let mut result = s.chars().collect::<Vec<_>>();
        for (_, indices) in components {
            let mut chars: Vec<char> = indices.iter().map(|&i| result[i]).collect();
            chars.sort();
            let mut indices = indices;
            indices.sort();

            for (i, &index) in indices.iter().enumerate() {
                result[index] = chars[i];
            }
        }

        result.into_iter().collect()
    }
}