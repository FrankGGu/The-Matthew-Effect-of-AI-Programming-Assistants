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
    pub fn smallest_string_with_swaps(s: String, pairs: Vec<Vec<i32>>) -> String {
        let n = s.len();
        let mut dsu = DSU::new(n);

        for pair in pairs {
            dsu.union(pair[0] as usize, pair[1] as usize);
        }

        let mut components: HashMap<usize, (Vec<char>, Vec<usize>)> = HashMap::new();
        let s_chars: Vec<char> = s.chars().collect();

        for i in 0..n {
            let root = dsu.find(i);
            let entry = components.entry(root).or_insert((Vec::new(), Vec::new()));
            entry.0.push(s_chars[i]);
            entry.1.push(i);
        }

        let mut result_chars: Vec<char> = vec![' '; n];

        for (_, (mut chars, mut indices)) in components {
            chars.sort_unstable();
            indices.sort_unstable();

            for k in 0..chars.len() {
                result_chars[indices[k]] = chars[k];
            }
        }

        result_chars.into_iter().collect()
    }
}