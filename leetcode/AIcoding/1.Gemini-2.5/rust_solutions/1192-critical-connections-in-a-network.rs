impl Solution {
    fn dfs_helper(
        u: usize,
        p: usize,
        adj: &Vec<Vec<usize>>,
        discovery_time: &mut Vec<i32>,
        low_link_value: &mut Vec<i32>,
        timer: &mut i32,
        bridges: &mut Vec<Vec<i32>>,
    ) {
        discovery_time[u] = *timer;
        low_link_value[u] = *timer;
        *timer += 1;

        for &v in adj[u].iter() {
            if v == p {
                continue;
            }

            if discovery_time[v] == -1 {
                Self::dfs_helper(v, u, adj, discovery_time, low_link_value, timer, bridges);
                low_link_value[u] = low_link_value[u].min(low_link_value[v]);
                if discovery_time[u] < low_link_value[v] {
                    bridges.push(vec![u as i32, v as i32]);
                }
            } else {
                low_link_value[u] = low_link_value[u].min(discovery_time[v]);
            }
        }
    }

    pub fn critical_connections(n: i32, connections: Vec<Vec<i32>>) -> Vec<Vec<i32>> {
        let n_usize = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize];
        for connection in connections {
            let u = connection[0] as usize;
            let v = connection[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut discovery_time: Vec<i32> = vec![-1; n_usize];
        let mut low_link_value: Vec<i32> = vec![-1; n_usize];
        let mut timer: i32 = 0;
        let mut bridges: Vec<Vec<i32>> = Vec::new();

        for i in 0..n_usize {
            if discovery_time[i] == -1 {
                Self::dfs_helper(i, n_usize, &adj, &mut discovery_time, &mut low_link_value, &mut timer, &mut bridges);
            }
        }

        bridges
    }
}