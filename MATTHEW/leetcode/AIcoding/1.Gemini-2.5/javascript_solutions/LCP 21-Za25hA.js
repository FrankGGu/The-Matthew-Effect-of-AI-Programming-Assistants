var maximumInvitations = function(favorite) {
    const n = favorite.length;
    const inDegree = new Array(n).fill(0);
    const adj = new Array(n).fill(0).map(() => []); // Reverse graph to find predecessors

    for (let i = 0; i < n; i++) {
        inDegree[favorite[i]]++;
        adj[favorite[i]].push(i);
    }

    const q = [];
    for (let i = 0; i < n; i++) {
        if (inDegree[i] === 0) {
            q.push(i);
        }
    }

    // Topological sort to remove nodes that are not part of any cycle
    // or are part of "in-trees" leading to cycles.
    while (q.length > 0) {
        const u = q.shift();
        const v = favorite[u]; // u likes v
        inDegree[v]--;
        if (inDegree[v] === 0) {
            q.push(v);
        }
    }

    // max_path_len[u] stores the length of the longest path from a non-cycle node
    // (a node with inDegree 0 after topological sort) to node u, including u itself.
    const max_path_len = new Array(n).fill(0);
    const visited_dfs = new Array(n).fill(false);

    // DFS to calculate max_path_len for nodes in in-trees.
    // This function calculates the length of the longest path ending at 'u'
    // where all nodes on the path (except possibly 'u') had their inDegree reduced to 0 by topo sort.
    const dfs_get_path_len = (u) => {
        if (visited_dfs[u]) {
            return max_path_len[u];
        }
        visited_dfs[u] = true;

        let current_max_len = 0;
        // Iterate over predecessors of u (nodes that like u)
        for (const prev of adj[u]) {
            if (inDegree[prev] === 0) { // If prev is a non-cycle node
                current_max_len = Math.max(current_max_len, dfs_get_path_len(prev));
            }
        }
        max_path_len[u] = current_max_len + 1; // +1 for node u itself
        return max_path_len[u];
    };

    // For all nodes that are part of cycles (inDegree > 0), calculate their max_path_len.
    // This will effectively calculate the length of the "in-tree" rooted at each cycle node.
    for (let i = 0; i < n; i++) {
        if (inDegree[i] > 0) { // If i is a cycle node
            dfs_get_path_len(i);
        }
    }

    let sum_of_cycle_lengths_ge_3 = 0;
    let sum_of_2_cycles_and_attached_trees = 0;
    const visited_cycle_finder = new Array(n).fill(false);

    // Find cycles and calculate contributions
    for (let i = 0; i < n; i++) {
        if (inDegree[i] > 0 && !visited_cycle_finder[i]) { // If i is a cycle node and not yet processed
            let curr = i;
            const path_in_cycle_finder = [];

            // Traverse the cycle
            while (!visited_cycle_finder[curr] && inDegree[curr] > 0) {
                visited_cycle_finder[curr] = true;
                path_in_cycle_finder.push(curr);
                curr = favorite[curr];
            }

            // curr is the node where the cycle closes.
            // Find where this node first appeared in our path_in_cycle_finder.
            const cycle_start_index = path_in_cycle_finder.indexOf(curr);
            const cycle_length = path_in_cycle_finder.length - cycle_start_index;

            if (cycle_length >= 3) {
                sum_of_cycle_lengths_ge_3 += cycle_length;
            } else { // cycle_length is 1 or 2
                // For cycles of length 1 or 2, we sum up the max_path_len for each node in the cycle.
                // This correctly accounts for the cycle nodes themselves and their attached "in-trees".
                for (let k = cycle_start_index; k < path_in_cycle_finder.length; k++) {
                    const node = path_in_cycle_finder[k];
                    sum_of_2_cycles_and_attached_trees += max_path_len[node];
                }
            }
        }
    }

    // The maximum number of invitations is the maximum of two scenarios:
    // 1. Sum of lengths of all cycles with length >= 3 (these can only invite cycle members).
    // 2. Sum of (length of 2-cycle + attached in-trees) for all 2-cycles,
    //    and (length of 1-cycle + attached in-trees) for all 1-cycles.
    return Math.max(sum_of_cycle_lengths_ge_3, sum_of_2_cycles_and_attached_trees);
};