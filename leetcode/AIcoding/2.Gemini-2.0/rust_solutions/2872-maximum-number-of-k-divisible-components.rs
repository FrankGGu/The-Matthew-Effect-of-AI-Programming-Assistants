impl Solution {
    pub fn max_k_divisible_components(n: i32, edges: Vec<Vec<i32>>, values: Vec<i32>, k: i32) -> i32 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![Vec::new(); n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut visited: Vec<bool> = vec![false; n];
        let mut count = 0;

        for i in 0..n {
            if !visited[i] {
                let mut stack: Vec<usize> = vec![i];
                visited[i] = true;
                let mut sum = 0;

                while let Some(u) = stack.pop() {
                    sum = (sum + values[u]) % k;

                    for &v in &adj[u] {
                        if !visited[v] {
                            visited[v] = true;
                            stack.push(v);
                        }
                    }
                }

                if sum == 0 {
                    count += 1;
                }
            }
        }

        count
    }
}