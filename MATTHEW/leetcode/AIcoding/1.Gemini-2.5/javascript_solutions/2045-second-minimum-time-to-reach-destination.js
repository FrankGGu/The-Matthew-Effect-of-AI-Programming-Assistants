var secondMinimum = function(n, edges, time, change) {
    const adj = Array(n + 1).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    // minTime[i][0] stores the first minimum time to reach node i
    // minTime[i][1] stores the second minimum time to reach node i
    const minTime = Array(n + 1).fill(0).map(() => [Infinity, Infinity]);

    const queue = [];

    // Start at node 1 with time 0
    minTime[1][0] = 0;
    queue.push([0, 1]); // [current_time_at_node_u, node_u]

    let head = 0;
    while (head < queue.length) {
        const [currentTime, u] = queue[head++];

        // Calculate actual time to leave node u, considering traffic lights
        let timeToLeaveU = currentTime;
        const numCycles = Math.floor(currentTime / change);
        if (numCycles % 2 === 1) { // If it's a red light period
            timeToLeaveU = (numCycles + 1) * change; // Wait until the next green light
        }

        const newTime = timeToLeaveU + time; // Time to arrive at neighbor v

        for (const v of adj[u]) {
            if (newTime < minTime[v][0]) {
                // Found a new first minimum time
                minTime[v][1] = minTime[v][0]; // Old first becomes new second
                minTime[v][0] = newTime;
                queue.push([newTime, v]);
            } else if (newTime > minTime[v][0] && newTime < minTime[v][1]) {
                // Found a new second minimum time (distinct from first)
                minTime[v][1] = newTime;
                queue.push([newTime, v]);
            }
        }
    }

    return minTime[n][1];
};