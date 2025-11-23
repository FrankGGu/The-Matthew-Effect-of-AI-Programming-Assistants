impl Solution {
    pub fn maximum_score(scores: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        let n = scores.len();
        let mut adj: Vec<Vec<(i32, i32)>> = vec![Vec::new(); n];
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push((scores[v], v as i32));
            adj[v].push((scores[u], u as i32));
        }

        for i in 0..n {
            adj[i].sort_by(|a, b| b.0.cmp(&a.0));
            if adj[i].len() > 3 {
                adj[i].truncate(3);
            }
        }

        let mut ans = -1;
        for edge in &edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;

            for &(s1, n1) in &adj[u] {
                if n1 as usize == v {
                    continue;
                }
                for &(s2, n2) in &adj[v] {
                    if n2 as usize == u || n2 == n1 {
                        continue;
                    }
                    let score = scores[u] + scores[v] + s1 + s2;
                    ans = ans.max(score);
                }
            }
        }

        ans
    }
}