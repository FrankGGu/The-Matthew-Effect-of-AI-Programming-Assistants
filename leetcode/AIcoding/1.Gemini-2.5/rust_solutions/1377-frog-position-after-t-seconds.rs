struct Solution;

impl Solution {
    pub fn frog_position(n: i332, edges: Vec<Vec<i32>>, t: i32, target: i32) -> f64 {
        let n_usize = n as usize;
        let target_usize = target as usize;

        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize + 1];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut visited: Vec<bool> = vec![false; n_usize + 1];

        Self::dfs(1, 0, 1.0, target_usize, t, &adj, &mut visited)
    }

    fn dfs(u: usize, time: i32, prob: f64, target: usize, t: i32, adj: &Vec<Vec<usize>>, visited: &mut Vec<bool>) -> f64 {
        visited[u] = true;

        let mut num_unvisited_children = 0;
        for &v in &adj[u] {
            if !visited[v] {
                num_unvisited_children += 1;
            }
        }

        if time == t {
            if u == target {
                visited[u] = false;
                return prob;
            } else {
                visited[u] = false;
                return 0.0;
            }
        }

        if u == target && num_unvisited_children == 0 {
            visited[u] = false;
            return prob;
        }

        if num_unvisited_children > 0 {
            let jump_prob = prob / num_unvisited_children as f64;
            let mut total_prob_from_children = 0.0;
            for &v in &adj[u] {
                if !visited[v] {
                    total_prob_from_children += Self::dfs(v, time + 1, jump_prob, target, t, adj, visited);
                }
            }
            visited[u] = false;
            return total_prob_from_children;
        } else {
            visited[u] = false;
            return 0.0;
        }
    }
}