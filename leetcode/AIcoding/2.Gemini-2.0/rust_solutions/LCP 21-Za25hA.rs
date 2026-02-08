use std::collections::VecDeque;

impl Solution {
    pub fn chasing_game(edges: Vec<Vec<i32>>, start_a: i32, start_b: i32) -> i32 {
        let n = edges.len() + 1;
        let mut adj = vec![vec![]; n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut dist_a = vec![-1; n];
        let mut dist_b = vec![-1; n];

        let mut q = VecDeque::new();
        q.push_back(start_a as usize);
        dist_a[start_a as usize] = 0;
        while !q.is_empty() {
            let u = q.pop_front().unwrap();
            for &v in &adj[u] {
                if dist_a[v as usize] == -1 {
                    dist_a[v as usize] = dist_a[u] + 1;
                    q.push_back(v as usize);
                }
            }
        }

        q.clear();
        q.push_back(start_b as usize);
        dist_b[start_b as usize] = 0;
        while !q.is_empty() {
            let u = q.pop_front().unwrap();
            for &v in &adj[u] {
                if dist_b[v as usize] == -1 {
                    dist_b[v as usize] = dist_b[u] + 1;
                    q.push_back(v as usize);
                }
            }
        }

        let mut ans = -1;
        for i in 1..n {
            if dist_a[i as usize] > dist_b[i as usize] {
                if ans == -1 || dist_a[i as usize] < ans {
                    ans = dist_a[i as usize];
                }
            }
        }

        ans
    }
}