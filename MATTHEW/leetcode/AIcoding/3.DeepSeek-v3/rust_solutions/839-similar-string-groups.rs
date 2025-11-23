impl Solution {
    pub fn num_similar_groups(strs: Vec<String>) -> i32 {
        let n = strs.len();
        let mut parent: Vec<usize> = (0..n).collect();
        let mut rank = vec![0; n];

        fn find(parent: &mut Vec<usize>, x: usize) -> usize {
            if parent[x] != x {
                parent[x] = find(parent, parent[x]);
            }
            parent[x]
        }

        fn union(parent: &mut Vec<usize>, rank: &mut Vec<usize>, x: usize, y: usize) {
            let x_root = find(parent, x);
            let y_root = find(parent, y);
            if x_root == y_root {
                return;
            }
            if rank[x_root] < rank[y_root] {
                parent[x_root] = y_root;
            } else {
                parent[y_root] = x_root;
                if rank[x_root] == rank[y_root] {
                    rank[x_root] += 1;
                }
            }
        }

        fn is_similar(a: &str, b: &str) -> bool {
            let a_chars: Vec<char> = a.chars().collect();
            let b_chars: Vec<char> = b.chars().collect();
            let mut diff = 0;
            for i in 0..a_chars.len() {
                if a_chars[i] != b_chars[i] {
                    diff += 1;
                    if diff > 2 {
                        return false;
                    }
                }
            }
            true
        }

        for i in 0..n {
            for j in i+1..n {
                if is_similar(&strs[i], &strs[j]) {
                    union(&mut parent, &mut rank, i, j);
                }
            }
        }

        let mut groups = 0;
        for i in 0..n {
            if parent[i] == i {
                groups += 1;
            }
        }
        groups
    }
}