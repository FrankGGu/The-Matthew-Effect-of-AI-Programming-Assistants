use std::collections::HashMap;

impl Solution {
    pub fn count_palindrome_paths(parent: Vec<i32>, s: String) -> i64 {
        let n = parent.len();
        let s = s.as_bytes();
        let mut graph = vec![vec![]; n];
        for i in 1..n {
            let p = parent[i] as usize;
            graph[p].push((i, s[i]));
        }

        let mut mask_count = HashMap::new();
        mask_count.insert(0, 1);
        let mut stack = vec![(0, 0)];
        let mut res = 0;

        while let Some((node, mask)) = stack.pop() {
            for &(child, c) in &graph[node] {
                let new_mask = mask ^ (1 << (c - b'a'));
                res += *mask_count.get(&new_mask).unwrap_or(&0);
                for i in 0..26 {
                    res += *mask_count.get(&(new_mask ^ (1 << i))).unwrap_or(&0);
                }
                *mask_count.entry(new_mask).or_insert(0) += 1;
                stack.push((child, new_mask));
            }
        }

        res
    }
}