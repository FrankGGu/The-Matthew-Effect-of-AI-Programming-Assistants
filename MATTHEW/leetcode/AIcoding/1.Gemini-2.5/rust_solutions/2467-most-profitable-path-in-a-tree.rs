struct Solution;

impl Solution {
    pub fn most_profitable_path(n: i32, edges: Vec<Vec<i32>>, amount: Vec<i32>, bob_start: i32) -> i32 {
        let n_usize = n as usize;
        let mut adj: Vec<Vec<usize>> = vec![vec![]; n_usize];
        for edge in edges {
            let u = edge[0] as usize;
            let v = edge[1] as usize;
            adj[u].push(v);
            adj[v].push(u);
        }

        let bob_start_node = bob_start as usize;
        let mut bob_times: Vec<i32> = vec![-1; n_usize]; // time Bob arrives at node i, or -1 if not on path

        let mut bob_path_nodes: Vec<usize> = Vec::new();

        // This DFS finds the unique path from `u` to `target` in a tree and stores it in `path`.
        // It returns true if `target` is found, false otherwise.
        fn find_bob_path_dfs(
            u: usize,
            parent: usize,
            target: usize,
            adj: &Vec<Vec<usize>>,
            path: &mut Vec<usize>,
        ) -> bool {
            path.push(u);
            if u == target {
                return true;
            }
            for &v in &adj[u] {
                if v == parent {
                    continue;
                }
                if find_bob_path_dfs(v, u, target, adj, path) {
                    return true;
                }
            }
            path.pop(); // Backtrack if this path doesn't lead to target
            false
        }

        // Call DFS to find Bob's path. `n_usize` is used as a dummy parent for the start node.
        find_bob_path_dfs(bob_start_node, n_usize, 0, &adj, &mut bob_path_nodes);

        // Populate bob_times based on the found path
        for (time, &node) in bob_path_nodes.iter().enumerate() {
            bob_times[node] = time as i32;
        }

        let mut max_profit = i32::MIN;

        // Alice's DFS function
        // `u`: current node Alice is visiting
        // `parent`: parent of `u` in Alice's path (to avoid going back)
        // `current_time`: Alice's arrival time at `u`
        // `current_profit_so_far`: accumulated profit up to `parent` of `u`
        // `adj`: adjacency list of the tree
        // `bob_times`: Bob's arrival times at nodes on his path to 0
        // `amount`: amounts for each node
        // `max_profit`: mutable reference to the global maximum profit found
        fn dfs_alice(
            u: usize,
            parent: usize,
            current_time: i32,
            mut current_profit_so_far: i32,
            adj: &Vec<Vec<usize>>,
            bob_times: &Vec<i32>,
            amount: &Vec<i32>,
            max_profit: &mut i32,
        ) {
            let node_amount = amount[u];
            let profit_at_u;

            if bob_times[u] == -1 || current_time < bob_times[u] {
                // Bob does not visit this node, or Alice arrives earlier
                profit_at_u = node_amount;
            } else if current_time == bob_times[u] {
                // Alice and Bob arrive at the same time
                profit_at_u = node_amount / 2;
            } else { // current_time > bob_times[u]
                // Bob arrives earlier
                profit_at_u = 0;
            }
            current_profit_so_far += profit_at_u;

            let mut has_unvisited_children = false;
            for &v in &adj[u] {
                if v == parent {
                    continue;
                }
                has_unvisited_children = true;
                dfs_alice(
                    v,
                    u,
                    current_time + 1,
                    current_profit_so_far,
                    adj,
                    bob_times,
                    amount,
                    max_profit,
                );
            }

            // If `u` is a leaf node (no children in Alice's path), update max_profit
            if !has_unvisited_children {
                *max_profit = (*max_profit).max(current_profit_so_far);
            }
        }

        // Start Alice's DFS from node 0. `n_usize` is used as a dummy parent for node 0.
        dfs_alice(0, n_usize, 0, 0, &adj, &bob_times, &amount, &mut max_profit);

        max_profit
    }
}