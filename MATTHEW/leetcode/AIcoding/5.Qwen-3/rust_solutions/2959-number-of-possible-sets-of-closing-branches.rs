impl Solution {

use std::collections::HashSet;

impl Solution {
    pub fn number_of_possible_sets(n: i32, parent: Vec<i32>, value: Vec<i32>) -> i32 {
        let n = n as usize;
        let mut children = vec![vec![]; n];
        for i in 0..n {
            if parent[i] != -1 {
                children[parent[i] as usize].push(i);
            }
        }

        fn dfs(node: usize, children: &[Vec<usize>], value: &[i32]) -> (i32, i32) {
            let mut sum = 0;
            let mut count = 1;
            for &child in &children[node] {
                let (s, c) = dfs(child, children, value);
                sum += s;
                count += c;
            }
            sum += value[node];
            (sum, count)
        }

        let (total_sum, total_count) = dfs(0, &children, &value);
        if total_sum == 0 {
            return total_count as i32;
        }
        0
    }
}
}