struct Solution {}

impl Solution {
    pub fn count_components(n: i32, edges: Vec<Vec<i32>>) -> i32 {
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
                count += 1;
                let mut q: Vec<usize> = Vec::new();
                q.push(i);
                visited[i] = true;
                let mut nodes = 0;
                let mut edges_count = 0;

                while !q.is_empty() {
                    let u = q.remove(0);
                    nodes += 1;
                    for &v in &adj[u] {
                        edges_count += 1;
                        if !visited[v] {
                            visited[v] = true;
                            q.push(v);
                        }
                    }
                }

                if edges_count != nodes * (nodes - 1) {
                    count -= 1;
                } else if nodes > 0 && edges_count != nodes * (nodes - 1) {
                    count -= 1;
                } else if nodes == 1 && edges_count != 0 {
                    count -= 1;
                } else if nodes == 0 && edges_count != 0{
                    count -= 1;
                }

                if edges_count > 0 {
                    if edges_count / 2 != nodes * (nodes - 1) / 2 {
                       if nodes * (nodes - 1) > 0 {
                           if edges_count != nodes * (nodes - 1) {
                            count -= 1;
                           } else if edges_count /2 != nodes * (nodes - 1) /2 {
                               count -=1;
                           }
                       }
                    }
                }

                if edges_count == 0 && nodes > 1 {
                    count -= 1;
                }
            }
        }

        count
    }
}