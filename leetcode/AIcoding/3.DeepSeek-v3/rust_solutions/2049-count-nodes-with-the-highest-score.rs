use std::collections::HashMap;

impl Solution {
    pub fn count_highest_score_nodes(parents: Vec<i32>) -> i32 {
        let n = parents.len();
        let mut children = vec![vec![]; n];
        for i in 1..n {
            let p = parents[i] as usize;
            children[p].push(i);
        }

        let mut size = vec![0; n];
        let mut max_score = 0;
        let mut count = 0;

        Self::dfs(0, &children, &mut size, &mut max_score, &mut count);

        count
    }

    fn dfs(node: usize, children: &Vec<Vec<usize>>, size: &mut Vec<i32>, max_score: &mut i64, count: &mut i32) -> i32 {
        let mut total_size = 1;
        let mut product = 1i64;

        for &child in &children[node] {
            let child_size = Self::dfs(child, children, size, max_score, count);
            total_size += child_size;
            product *= child_size as i64;
        }

        let remaining = size.len() as i32 - total_size;
        if remaining > 0 {
            product *= remaining as i64;
        }

        if product > *max_score {
            *max_score = product;
            *count = 1;
        } else if product == *max_score {
            *count += 1;
        }

        size[node] = total_size;
        total_size
    }
}