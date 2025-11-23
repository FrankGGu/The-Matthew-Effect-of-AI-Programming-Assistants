var maxPathQuality = function(values, edges, maxTime) {
    const n = values.length;
    let adj = Array(n).fill(0).map(() => []);

    for (const [u, v, time] of edges) {
        adj[u].push([v, time]);
        adj[v].push([u, time]);
    }

    let maxQuality = 0;

    // visitedCounts[i] stores how many times node i has been visited in the current path.
    // We need to pass a copy of this array to recursive calls to ensure backtracking works.
    let initialVisitedCounts = new Array(n).fill(0);

    // Node 0 is visited at the start. Its value is always included.
    initialVisitedCounts[0] = 1;
    maxQuality = values[0]; // Initialize with quality of just node 0.

    function dfs(u, currentTime, currentQuality, visitedCounts) {
        // The problem states "ends at node 0". So, only update maxQuality if we are at node 0.
        // This is the literal interpretation of the problem statement.
        if (u === 0) {
            maxQuality = Math.max(maxQuality, currentQuality);
        }

        for (const [v, time] of adj[u]) {
            if (currentTime + time <= maxTime) {
                let newQuality = currentQuality;
                let newVisitedCounts = [...visitedCounts]; // Create a shallow copy for backtracking

                // If this is the first time visiting 'v' in this path, add its value to quality
                if (newVisitedCounts[v] === 0) {
                    newQuality += values[v];
                }
                newVisitedCounts[v]++; // Mark 'v' as visited one more time

                dfs(v, currentTime + time, newQuality, newVisitedCounts);
            }
        }
    }

    dfs(0, 0, values[0], initialVisitedCounts);

    return maxQuality;
};