use std::collections::HashMap;

impl Solution {
    pub fn count_palindrome_paths(parent: Vec<i32>, s: String) -> i64 {
        let n = parent.len();
        let s_bytes = s.as_bytes();
        let mut adj: Vec<Vec<usize>> = vec![Vec::new(); n];

        for i in 1..n {
            adj[parent[i] as usize].push(i);
        }

        let mut count: i64 = 0;
        let mut freq: HashMap<(usize, i32), i64> = HashMap::new();
        *freq.entry((0, 0)).or_insert(0) += 1;

        fn dfs(
            node: usize,
            mask: i32,
            adj: &Vec<Vec<usize>>,
            s_bytes: &Vec<u8>,
            freq: &mut HashMap<(usize, i32), i64>,
            count: &mut i64,
        ) {
            let new_mask = mask ^ (1 << (s_bytes[node] - b'a'));

            *count += *freq.get(&(node, new_mask)).unwrap_or(&0);

            for i in 0..26 {
                let target_mask = new_mask ^ (1 << i);
                *count += *freq.get(&(node, target_mask)).unwrap_or(&0);
            }

            *freq.entry((node, new_mask)).or_insert(0) += 1;

            for &neighbor in &adj[node] {
                dfs(neighbor, new_mask, adj, s_bytes, freq, count);
            }

            *freq.entry((node, new_mask)).or_insert(0) -= 1;
        }

        for &neighbor in &adj[0] {
            dfs(neighbor, 1 << (s_bytes[0] - b'a'), &adj, &s_bytes.to_vec(), &mut freq, &mut count);
        }

        count
    }
}