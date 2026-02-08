use std::collections::HashMap;

impl Solution {
    pub fn count_highest_score_nodes(parents: Vec<i32>) -> i32 {
        let n = parents.len();
        let mut children: Vec<Vec<usize>> = vec![vec![]; n];
        for (i, &p) in parents.iter().enumerate() {
            if p != -1 {
                children[p as usize].push(i);
            }
        }

        let mut sizes = vec![0; n];
        let mut score = vec![1; n];

        fn dfs(node: usize, children: &Vec<Vec<usize>>, sizes: &mut Vec<usize>, score: &mut Vec<i64>) {
            sizes[node] = 1;
            let mut total_size = 1;
            for &child in &children[node] {
                dfs(child, children, sizes, score);
                total_size += sizes[child];
            }
            sizes[node] = total_size;
            score[node] = total_size;
        }

        dfs(0, &children, &mut sizes, &mut score);

        let mut max_score = 0;
        let mut count = 0;

        for i in 0..n {
            let mut curr_score = 1;
            if parents[i] != -1 {
                curr_score *= (n - sizes[i]) as i64;
            }
            for &child in &children[i] {
                curr_score *= sizes[child] as i64;
            }
            if curr_score > max_score {
                max_score = curr_score;
                count = 1;
            } else if curr_score == max_score {
                count += 1;
            }
        }

        count
    }
}