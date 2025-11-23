struct Solution;

impl Solution {
    pub fn supply_wagons(n: i32, edges: Vec<Vec<i32>>, needs: Vec<i32>, capacity: i32) -> i32 {
        let n_usize = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut total_wagons = 0;

        fn dfs(
            u: usize,
            p: usize,
            adj: &Vec<Vec<usize>>,
            needs: &Vec<i32>,
            capacity: i32,
            total_wagons: &mut i32,
        ) -> i32 {
            let mut current_load = needs[u];

            for &v in &adj[u] {
                if v == p {
                    continue;
                }
                current_load += dfs(v, u, adj, needs, capacity, total_wagons);
            }

            if u == 0 {
                if current_load > 0 {
                    *total_wagons += (current_load + capacity - 1) / capacity;
                }
                return 0;
            } else {
                if current_load == 0 {
                    return 0;
                }
                if current_load <= capacity {
                    return current_load;
                } else {
                    *total_wagons += (current_load - 1) / capacity;
                    return capacity;
                }
            }
        }

        dfs(0, n_usize, &adj, &needs, capacity, &mut total_wagons);

        total_wagons
    }
}