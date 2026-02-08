impl Solution {
    pub fn ways_to_assign_directions(n: i32, edges: Vec<Vec<i32>>) -> i32 {
        let mut adj: Vec<Vec<usize>> = vec![Vec::new(); n as usize];
        for edge in &edges {
            let u = (edge[0] - 1) as usize;
            let v = (edge[1] - 1) as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut ans = 1;
        for _ in 0..edges.len() {
            ans = (ans * 3) % 1000000007;
        }
        ans
    }
}