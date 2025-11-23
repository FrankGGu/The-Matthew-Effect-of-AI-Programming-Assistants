impl Solution {
    pub fn minimum_fuel_cost(roads: Vec<Vec<i32>>, seats: i32) -> i64 {
        let n = roads.len() + 1;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n];
        for road in roads {
            let u = road[0] as usize;
            let v = road[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let mut total_fuel_cost: i64 = 0;
        // Start DFS from the capital (node 0).
        // Use 'n' as a dummy parent for the capital, as 'n' is not a valid node index.
        Self::dfs(0, n, &adj, seats, &mut total_fuel_cost);

        total_fuel_cost
    }

    // This DFS function returns the total number of people in the subtree rooted at 'node'
    // (including the person at 'node' itself).
    fn dfs(node: usize, parent: usize, adj: &Vec<Vec<usize>>, seats: i32, fuel_cost: &mut i64) -> i64 {
        let mut people_in_subtree: i64 = 1; // Start with 1 person at the current node

        for &neighbor in &adj[node] {
            if neighbor == parent {
                continue;
            }

            let people_in_child_subtree = Self::dfs(neighbor, node, adj, seats, fuel_cost);
            people_in_subtree += people_in_child_subtree;

            // Calculate cars needed to transport people from the child subtree to the current node.
            // This is a ceiling division: (a + b - 1) / b
            let cars_needed = (people_in_child_subtree + seats as i64 - 1) / seats as i64;
            *fuel_cost += cars_needed;
        }

        people_in_subtree
    }
}