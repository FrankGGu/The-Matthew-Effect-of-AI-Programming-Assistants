use std::collections::VecDeque;

fn get_component_size(start_node: usize, prime_node_p: usize, adj: &Vec<Vec<usize>>, is_prime: &Vec<bool>, visited: &mut Vec<bool>) -> i64 {
    let mut size = 0;
    let mut q = VecDeque::new();

    q.push_back(start_node);
    visited[start_node] = true;
    size += 1;

    while let Some(u) = q.pop_front() {
        for &v in &adj[u] {
            if v == prime_node_p || is_prime[v] || visited[v] {
                continue;
            }
            visited[v] = true;
            size += 1;
            q.push_back(v);
        }
    }
    size
}

struct Solution;

impl Solution {
    pub fn count_paths(n: i32, edges: Vec<Vec<i32>>) -> i64 {
        let n = n as usize;

        let mut is_prime = vec![true; n + 1];
        if n >= 0 { is_prime[0] = false; }
        if n >= 1 { is_prime[1] = false; }
        for i in 2..=(n as f64).sqrt() as usize {
            if is_prime[i] {
                for multiple in (i * i..=n).step_by(i) {
                    is_prime[multiple] = false;
                }
            }
        }

        let mut adj: Vec<Vec<usize>> = vec![vec![]; n + 1];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut total_valid_paths: i64 = 0;

        for i in 1..=n {
            if is_prime[i] {
                let mut sum_of_component_sizes: i64 = 0;
                let mut current_prime_paths_contribution: i64 = 0;

                let mut visited_for_dfs = vec![false; n + 1];
                visited_for_dfs[i] = true;

                for &neighbor in &adj[i] {
                    if !is_prime[neighbor] {
                        let component_size = get_component_size(neighbor, i, &adj, &is_prime, &mut visited_for_dfs);

                        current_prime_paths_contribution += component_size;
                        current_prime_paths_contribution += sum_of_component_sizes * component_size;

                        sum_of_component_sizes += component_size;
                    }
                }
                total_valid_paths += current_prime_paths_contribution + 1;
            }
        }

        total_valid_paths
    }
}