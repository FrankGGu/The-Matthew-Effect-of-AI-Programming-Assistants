impl Solution {
    pub fn longest_cycle(edges: Vec<i32>) -> i32 {
        let n = edges.len();
        let mut max_cycle_len = -1;
        let mut visited_time: Vec<i32> = vec![-1; n];
        let mut dfs_finished: Vec<bool> = vec![false; n];

        for i in 0..n {
            if !dfs_finished[i] {
                Self::dfs(
                    i,
                    0,
                    &edges,
                    &mut visited_time,
                    &mut dfs_finished,
                    &mut max_cycle_len,
                );
            }
        }

        max_cycle_len
    }

    fn dfs(
        u: usize,
        time: i32,
        edges: &Vec<i32>,
        visited_time: &mut Vec<i32>,
        dfs_finished: &mut Vec<bool>,
        max_cycle_len: &mut i32,
    ) {
        visited_time[u] = time;

        let next_node_idx = edges[u];

        if next_node_idx != -1 {
            let v = next_node_idx as usize;

            if visited_time[v] != -1 {
                *max_cycle_len = (*max_cycle_len).max(time - visited_time[v] + 1);
            } else if !dfs_finished[v] {
                Self::dfs(v, time + 1, edges, visited_time, dfs_finished, max_cycle_len);
            }
        }

        dfs_finished[u] = true;
        visited_time[u] = -1;
    }
}