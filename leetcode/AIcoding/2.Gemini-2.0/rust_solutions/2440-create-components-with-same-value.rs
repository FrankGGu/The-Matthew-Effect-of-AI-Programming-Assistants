use std::collections::HashMap;

impl Solution {
    pub fn component_value(edges: Vec<Vec<i32>>, nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut sum: i32 = nums.iter().sum();

        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        for k in (1..=n).rev() {
            if sum % (k as i32) == 0 {
                let target = sum / (k as i32);
                let mut possible = true;
                let mut visited = vec![false; n];

                fn dfs(
                    u: usize,
                    adj: &Vec<Vec<usize>>,
                    nums: &Vec<i32>,
                    visited: &mut Vec<bool>,
                    target: i32,
                ) -> i32 {
                    visited[u] = true;
                    let mut current_sum = nums[u];

                    for &v in &adj[u] {
                        if !visited[v] {
                            let child_sum = dfs(v, adj, nums, visited, target);
                            if child_sum == -1 {
                                return -1;
                            }
                            current_sum += child_sum;
                        }
                    }

                    if current_sum > target {
                        return -1;
                    } else if current_sum == target {
                        return 0;
                    } else {
                        return current_sum;
                    }
                }

                for i in 0..n {
                    if !visited[i] {
                        if dfs(i, &adj, &nums, &mut visited, target) != 0 {
                            possible = false;
                            break;
                        }
                    }
                }

                if possible {
                    return (k - 1) as i32;
                }
            }
        }

        0
    }
}