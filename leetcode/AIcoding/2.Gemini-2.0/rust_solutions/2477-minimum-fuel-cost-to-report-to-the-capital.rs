impl Solution {
    pub fn minimum_fuel_cost(n: i32, roads: Vec<Vec<i32>>, seats: i32) -> i64 {
        let n = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![Vec::new(); n];
        for road in &roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut visited: Vec<bool> = vec![false; n];
        let mut total_fuel: i64 = 0;

        fn dfs(node: usize, parent: usize, adj: &Vec<Vec<usize>>, visited: &mut Vec<bool>, seats: i32, total_fuel: &mut i64) -> i64 {
            visited[node] = true;
            let mut people: i64 = 1;

            for &neighbor in &adj[node] {
                if neighbor != parent {
                    people += dfs(neighbor, node, adj, visited, seats, total_fuel);
                }
            }

            if node != 0 {
                *total_fuel += (people + seats as i64 - 1) / seats as i64;
            }

            people
        }

        dfs(0, 0, &adj, &mut visited, seats, &mut total_fuel);

        total_fuel
    }
}