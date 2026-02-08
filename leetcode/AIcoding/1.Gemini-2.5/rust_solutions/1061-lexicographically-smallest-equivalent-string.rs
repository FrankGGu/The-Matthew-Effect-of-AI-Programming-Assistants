struct UnionFind {
    parent: [u8; 26],
}

impl UnionFind {
    fn new() -> Self {
        let mut parent = [0; 26];
        for i in 0..26 {
            parent[i] = i as u8;
        }
        UnionFind { parent }
    }

    fn find(&mut self, i: u8) -> u8 {
        if self.parent[i as usize] == i {
            i
        } else {
            self.parent[i as usize] = self.find(self.parent[i as usize],);
            self.parent[i as usize]
        }
    }

    fn union(&mut self, i: u8, j: u8) {
        let root_i = self.find(i);
        let root_j = self.find(j);

        if root_i != root_j {
            if root_i < root_j {
                self.parent[root_j as usize] = root_i;
            } else {
                self.parent[root_i as usize] = root_j;
            }
        }
    }
}

impl Solution {
    pub fn smallest_equivalent_string(s1: String, s2: String, base_str: String) -> String {
        let mut uf = UnionFind::new();

        let s1_chars: Vec<char> = s1.chars().collect();
        let s2_chars: Vec<char> = s2.chars().collect();

        for i in 0..s1_chars.len() {
            let char1_idx = (s1_chars[i] as u8) - b'a';
            let char2_idx = (s2_chars[i] as u8) - b'a';
            uf.union(char1_idx, char2_idx);
        }

        let mut result = String::with_capacity(base_str.len());
        for c in base_str.chars() {
            let char_idx = (c as u8) - b'a';
            let smallest_equivalent_idx = uf.find(char_idx);
            result.push((smallest_equivalent_idx + b'a') as char);
        }

        result
    }
}