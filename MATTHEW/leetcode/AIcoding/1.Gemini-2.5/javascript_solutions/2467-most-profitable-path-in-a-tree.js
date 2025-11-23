var mostProfitablePath = function(n, edges, amounts, bob) {
    const adj = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    // Step 1: Find Alice's path and arrival times
    // aliceTime[i] stores the time Alice arrives at node i.
    // If Alice does not visit node i on her path to 'bob', aliceTime[i] remains Infinity.
    const aliceTime = new Array(n).fill(Infinity);
    let foundBob = false;

    // DFS to find Alice's path from node 0 to 'bob' and record her arrival times.
    function findAlicePathDFS(u, p, time) {
        aliceTime[u] = time; // Mark current node with Alice's arrival time

        if (u === bob) {
            foundBob = true; // Bob's node found, Alice's path is complete up to this point
            return;
        }

        for (const v of adj[u]) {
            if (v !== p) {
                findAlicePathDFS(v, u, time + 1);
                if (foundBob) {
                    // If bob was found in a child branch, propagate this information up
                    // This node 'u' is on Alice's path to 'bob'
                    return;
                }
            }
        }

        // If 'bob' was not found in any child branch, this node 'u' is not on Alice's path to 'bob'.
        // So, reset its aliceTime to Infinity.
        if (!foundBob) {
            aliceTime[u] = Infinity;
        }
    }

    findAlicePathDFS(0, -1, 0);

    // Step 2: Bob's DFS to calculate the maximum profit
    let maxProfit = -Infinity; // Initialize with negative infinity as amounts can be negative

    // DFS for Bob to explore all paths from node 0 to any leaf node
    function dfsBob(u, p, bobTime, currentProfit) {
        let profitForNodeU = 0;
        if (aliceTime[u] === Infinity || bobTime < aliceTime[u]) {
            // Alice not on this path, or Bob arrives earlier than Alice
            profitForNodeU = amounts[u];
        } else if (bobTime === aliceTime[u]) {
            // Bob and Alice arrive at the same time
            profitForNodeU = amounts[u] / 2;
        }
        // If bobTime > aliceTime[u], profitForNodeU remains 0 (Alice arrived earlier)

        currentProfit += profitForNodeU;

        let isLeaf = true;
        for (const v of adj[u]) {
            if (v !== p) {
                isLeaf = false; // This node is not a leaf if it has an unvisited child
                dfsBob(v, u, bobTime + 1, currentProfit);
            }
        }

        // If 'u' is a leaf node (no unvisited children), update maxProfit
        if (isLeaf) {
            maxProfit = Math.max(maxProfit, currentProfit);
        }
    }

    dfsBob(0, -1, 0, 0); // Start Bob's DFS from node 0 at time 0 with initial profit 0

    return maxProfit;
};