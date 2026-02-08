use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn smallest_string_with_swaps(s: String, pairs: Vec<Vec<i32>>) -> String {
        let n = s.len();
        let mut parent: Vec<usize> = (0..n).collect();

        fn find(u: usize, parent: &mut Vec<usize>) -> usize {
            if parent[u] != u {
                parent[u] = find(parent[u], parent);
            }
            parent[u]
        }

        fn union(u: usize, v: usize, parent: &mut Vec<usize>) {
            let root_u = find(u, parent);
            let root_v = find(v, parent);
            if root_u != root_v {
                parent[root_v] = root_u;
            }
        }

        for pair in pairs {
            let u = pair[0] as usize;
            let v = pair[1] as usize;
            union(u, v, &mut parent);
        }

        let mut groups: HashMap<usize, Vec<usize>> = HashMap::new();
        for i in 0..n {
            let root = find(i, &mut parent);
            groups.entry(root).or_insert_with(Vec::new).push(i);
        }

        let mut res: Vec<char> = s.chars().collect();
        for (_, indices) in groups {
            let mut chars: Vec<char> = indices.iter().map(|&i| res[i]).collect();
            chars.sort_unstable();
            let mut sorted_indices = indices.clone();
            sorted_indices.sort_unstable();
            for (i, &idx) in sorted_indices.iter().enumerate() {
                res[idx] = chars[i];
            }
        }

        res.into_iter().collect()
    }
}