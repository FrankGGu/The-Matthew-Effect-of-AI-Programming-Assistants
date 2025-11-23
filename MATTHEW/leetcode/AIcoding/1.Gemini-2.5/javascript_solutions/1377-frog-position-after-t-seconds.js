var frogPosition = function(n, edges, t, target) {
    const adj = Array.from({ length: n + 1 }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let ansProb = 0.0;

    // dfs(u, p, time_curr, prob_curr)
    // u: current node
    // p: parent node (from which u was reached)
    // time_curr: current time elapsed
    // prob_curr: probability of being at u at time_curr
    function dfs(u, p, time_curr, prob_curr) {
        // If current time exceeds the total time t, this path is invalid.
        if (time_curr > t) {
            return;
        }

        // Calculate the number of possible jumps from node u.
        // For the starting node (1), all neighbors are choices.
        // For other nodes, we exclude the parent node (p) from choices to avoid going back.
        let numJumpsPossible = 0;
        if (u === 1) {
            numJumpsPossible = adj[u].length;
        } else {
            numJumpsPossible = adj[u].length - 1;
        }

        // Check if the current node is the target island.
        if (u === target) {
            // If the current time is exactly t, this is a successful path.
            if (time_curr === t) {
                ansProb = prob_curr;
                return;
            }
            // If the current time is less than t, but the frog cannot make any further jumps
            // (i.e., it has no unvisited neighbors), it stays at this island until time t.
            if (time_curr < t && numJumpsPossible === 0) {
                ansProb = prob_curr;
                return;
            }
            // If the current time is less than t, and the frog CAN jump further,
            // it MUST jump. Therefore, it will not be at the target island at time t.
            // In this scenario, we do not update ansProb and implicitly return.
        }

        // If the frog can make further jumps (numJumpsPossible > 0), it must jump.
        // We explore each valid neighbor.
        if (numJumpsPossible > 0) {
            for (const v of adj[u]) {
                if (v !== p) { // Ensure we don't jump back to the parent node
                    dfs(v, u, time_curr + 1, prob_curr / numJumpsPossible);
                }
            }
        }
        // If numJumpsPossible is 0 and the current node is not the target (or if it is target
        // but must jump as per the logic above), this path ends without contributing
        // to ansProb (unless already handled).
    }

    // Start the Depth First Search from island 1.
    // Initial state: current node = 1, parent = 0 (dummy), time = 0, probability = 1.0.
    dfs(1, 0, 0, 1.0);

    return ansProb;
};