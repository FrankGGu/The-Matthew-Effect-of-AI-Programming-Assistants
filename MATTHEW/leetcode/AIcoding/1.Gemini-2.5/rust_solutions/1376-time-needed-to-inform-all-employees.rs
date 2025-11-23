impl Solution {
    pub fn num_of_minutes(n: i32, head_id: i32, manager: Vec<i32>, inform_time: Vec<i32>) -> i32 {
        let n_usize = n as usize;
        let head_id_usize = head_id as usize;

        let mut adj: Vec<Vec<i32>> = vec![vec![]; n_usize];
        for i in 0..n_usize {
            if manager[i] != -1 {
                adj[manager[i] as usize].push(i as i32);
            }
        }

        fn dfs(
            u: i32,
            current_accumulated_time: i32,
            adj: &Vec<Vec<i32>>,
            inform_time: &Vec<i32>,
        ) -> i32 {
            let u_usize = u as usize;
            let mut max_total_time = current_accumulated_time;

            if adj[u_usize].is_empty() {
                // If 'u' has no subordinates, it's a leaf node.
                // The time for 'u' to be informed is 'current_accumulated_time'.
                // 'u' doesn't inform anyone further, so its 'inform_time' is not added
                // to subsequent paths.
                return current_accumulated_time;
            }

            for &v in adj[u_usize].iter() {
                // Time to inform subordinate 'v' is:
                // (time taken to reach 'u') + (time for 'u' to inform 'v')
                let time_for_v = current_accumulated_time + inform_time[u_usize];
                max_total_time = max_total_time.max(dfs(v, time_for_v, adj, inform_time));
            }

            max_total_time
        }

        dfs(head_id, 0, &adj, &inform_time)
    }
}