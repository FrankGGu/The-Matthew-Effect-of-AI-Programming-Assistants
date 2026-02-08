use std::collections::HashMap;

impl Solution {
    pub fn count_highest_score_nodes(parents: Vec<i32>) -> i32 {
        let n = parents.len();
        let mut children: Vec<Vec<usize>> = vec![Vec::new(); n];
        for (i, &p) in parents.iter().enumerate() {
            if p != -1 {
                children[p as usize].push(i);
            }
        }

        let mut sizes = vec![0; n];

        fn dfs(node: usize, children: &Vec<Vec<usize>>, sizes: &mut Vec<usize>) -> usize {
            let mut size = 1;
            for &child in &children[node] {
                size += dfs(child, children, sizes);
            }
            sizes[node] = size;
            size
        }

        dfs(parents.iter().position(|&x| x == -1).unwrap(), &children, &mut sizes);

        let mut counts: HashMap<u64, i32> = HashMap::new();

        for i in 0..n {
            let mut score: u64 = 1;
            let mut remaining = n - sizes[i];

            if remaining > 0 {
                score *= remaining as u64;
            }

            for &child in &children[i] {
                score *= sizes[child] as u64;
            }

            *counts.entry(score).or_insert(0) += 1;
        }

        *counts.iter().max_by_key(|&(k, _)| k).unwrap().1
    }
}