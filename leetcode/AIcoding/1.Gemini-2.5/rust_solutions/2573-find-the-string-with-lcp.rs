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
            self.parent[i] = self.find(self.parent[i]);
            self.parent[i]
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
    pub fn find_the_string(lcp: Vec<Vec<i32>>) -> String {
        let n = lcp.len();
        if n == 0 {
            return "".to_string();
        }

        let mut dsu = DSU::new(n);

        for i in 0..n {
            for j in i + 1..n {
                if lcp[i][j] > 0 {
                    dsu.union(i, j);
                }
            }
        }

        for i in 0..n {
            for j in i + 1..n {
                if lcp[i][j] == 0 {
                    if dsu.find(i) == dsu.find(j) {
                        return "".to_string();
                    }
                }
            }
        }

        let mut s_chars: Vec<char> = vec![' '; n];
        let mut next_char_code: u8 = b'a';

        for i in 0..n {
            if s_chars[i] == ' ' {
                let root = dsu.find(i);
                if next_char_code > b'z' {
                    return "".to_string();
                }
                let char_to_assign = next_char_code as char;
                for k in 0..n {
                    if dsu.find(k) == root {
                        s_chars[k] = char_to_assign;
                    }
                }
                next_char_code += 1;
            }
        }

        let s_candidate: String = s_chars.iter().collect();

        let mut computed_lcp: Vec<Vec<i32>> = vec![vec![0; n]; n];

        for i in (0..n).rev() {
            for j in (0..n).rev() {
                if i == j {
                    computed_lcp[i][j] = n as i32;
                } else if s_chars[i] == s_chars[j] {
                    if i + 1 < n && j + 1 < n {
                        computed_lcp[i][j] = 1 + computed_lcp[i + 1][j + 1];
                    } else {
                        computed_lcp[i][j] = 1;
                    }
                } else {
                    computed_lcp[i][j] = 0;
                }
            }
        }

        for i in 0..n {
            for j in 0..n {
                if computed_lcp[i][j] != lcp[i][j] {
                    return "".to_string();
                }
            }
        }

        s_candidate
    }
}