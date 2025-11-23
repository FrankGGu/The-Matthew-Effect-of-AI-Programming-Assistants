struct Solution;

impl Solution {
    pub fn count_pairs_of_connectable_servers(edges: Vec<Vec<i32>>, signal_speed: i32) -> Vec<i32> {
        let n = edges.len() + 1;
        let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n];

        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            let w = edge[2];
            adj[u].push((v, w));
            adj[v].push((u, w));
        }

        let mut ans: Vec<i32> = vec![0; n];

        for i in 0..n {
            let mut sum_counts_from_prev_branches = 0;
            let mut current_server_pairs = 0;

            for &(neighbor, weight) in adj[i].iter() {
                let count_connectable_in_branch = Self::dfs_count_valid(neighbor, i, weight, signal_speed, &adj);

                current_server_pairs += sum_counts_from_prev_branches * count_connectable_in_branch;

                sum_counts_from_prev_branches += count_connectable_in_branch;
            }
            ans[i] = current_server_pairs;
        }

        ans
    }

    fn dfs_count_valid(u: usize, parent: usize, current_dist: i32, signal_speed: i32, adj: &Vec<Vec<(usize, i32)>>) -> i32 {
        let mut count = 0;

        if current_dist % signal_speed == 0 {
            count = 1;
        } else {
            return 0;
        }

        for &(v, w) in adj[u].iter() {
            if v != parent {
                count += Self::dfs_count_valid(v, u, current_dist + w, signal_speed, adj);
            }
        }
        count
    }
}