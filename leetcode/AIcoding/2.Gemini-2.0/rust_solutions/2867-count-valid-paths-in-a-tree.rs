impl Solution {
    pub fn count_valid_paths(n: i32, edges: Vec<Vec<i32>>) -> i64 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n + 1];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let is_prime = |x: usize| -> bool {
            if x <= 1 {
                return false;
            }
            for i in 2..=((x as f64).sqrt() as usize) {
                if x % i == 0 {
                    return false;
                }
            }
            true
        };

        let mut ans = 0;
        for i in 1..=n {
            if is_prime(i) {
                let mut visited = vec![false; n + 1];
                visited[i] = true;
                for &neighbor in &adj[i] {
                    let mut count = 0;
                    let mut q = vec![neighbor];
                    visited[neighbor] = true;
                    while let Some(u) = q.pop() {
                        if !is_prime(u) {
                            count += 1;
                            for &v in &adj[u] {
                                if !visited[v] {
                                    visited[v] = true;
                                    q.push(v);
                                }
                            }
                        }
                    }
                    ans += count;
                }
            }
        }

        for i in 1..=n {
            if !is_prime(i) {
                ans += 1;
            }
        }

        ans
    }
}