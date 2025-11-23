pub fn max_score(n: i32, edges: Vec<Vec<i32>>, values: Vec<i32>, k: i32) -> i64 {
    use std::collections::{HashMap, HashSet};

    let mut graph = vec![vec![]; n as usize];
    for edge in edges {
        graph[edge[0] as usize].push(edge[1]);
        graph[edge[1] as usize].push(edge[0]);
    }

    let mut dp = vec![vec![0; k as usize + 1]; n as usize];
    let mut visited = vec![false; n as usize];

    fn dfs(node: usize, parent: Option<usize>, graph: &Vec<Vec<i32>>, values: &Vec<i32>, dp: &mut Vec<Vec<i64>>, visited: &mut Vec<bool>, k: i32) {
        visited[node] = true;
        let mut children_scores = vec![];

        for &neighbor in &graph[node] {
            if let Some(p) = parent {
                if neighbor == p { continue; }
            }
            dfs(neighbor as usize, Some(node), graph, values, dp, visited, k);
            children_scores.push(dp[neighbor as usize].to_vec());
        }

        let mut current_values = vec![0; k as usize + 1];
        for i in 0..=k as usize {
            current_values[i] = (i as i64) * values[node] as i64;
        }

        for scores in children_scores {
            let mut new_values = current_values.clone();
            for i in 0..=k as usize {
                for j in 0..=k as usize - i {
                    new_values[i + j] = new_values[i + j].max(current_values[i] + scores[j]);
                }
            }
            current_values = new_values;
        }

        for i in 0..=k as usize {
            dp[node][i] = current_values[i];
        }
    }

    dfs(0, None, &graph, &values, &mut dp, &mut visited, k);
    dp[0].iter().cloned().max().unwrap_or(0)
}