use std::cell::RefCell;
use std::rc::Rc;

impl Solution {
    pub fn count_subtrees(n: i32, edges: Vec<Vec<i32>>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut ans = vec![0; queries.len()];
        for (i, query) in queries.iter().enumerate() {
            let u = query[0] as usize;
            let v = query[1] as usize;

            let mut new_adj: Vec<Vec<usize>> = vec![vec![]; n];
            for i in 0..n {
                for &neighbor in &adj[i] {
                    if (i == u && neighbor == v) || (i == v && neighbor == u) {
                        continue;
                    }
                    new_adj[i].push(neighbor);
                }
            }

            let mut sizes = vec![0; n];
            for start_node in 0..n {
                let mut visited = vec![false; n];
                let mut q = vec![start_node];
                visited[start_node] = true;
                let mut count = 0;

                while let Some(curr) = q.pop() {
                    count += 1;
                    for &neighbor in &new_adj[curr] {
                        if !visited[neighbor] {
                            visited[neighbor] = true;
                            q.push(neighbor);
                        }
                    }
                }
                sizes[start_node] = count;
            }

            ans[i] = sizes.into_iter().filter(|&x| x == 1).count() as i32;
        }

        ans
    }
}

struct Solution;