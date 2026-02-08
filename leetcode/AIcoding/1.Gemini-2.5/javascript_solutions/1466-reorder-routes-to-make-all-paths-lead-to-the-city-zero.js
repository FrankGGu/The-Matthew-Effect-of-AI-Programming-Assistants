var minReorder = function(n, connections) {
    // Create an adjacency list to represent the graph.
    // For each node u, graph[u] will store an array of [neighbor, cost].
    // cost = 1 if the original edge was u -> neighbor (needs reversal for neighbor to reach u).
    // cost = 0 if the original edge was neighbor -> u (already correctly oriented for neighbor to reach u).
    const graph = new Array(n).fill(0).map(() => []);

    for (const [u, v] of connections) {
        // Original edge: u -> v
        // If we traverse from u to v (away from city 0), this edge needs to be reversed.
        graph[u].push([v, 1]);
        // If we traverse from v to u (towards city 0), this edge is already correctly oriented.
        graph[v].push([u, 0]);
    }

    let reversals = 0;
    const visited = new Array(n).fill(false);
    const queue = [0]; // Start BFS from city 0
    visited[0] = true;

    let head = 0; // Pointer for efficient queue processing (avoids array.shift())
    while (head < queue.length) {
        const u = queue[head++];

        for (const [v, cost] of graph[u]) {
            if (!visited[v]) {
                visited[v] = true;
                reversals += cost; // Add the cost (1 if reversal needed, 0 otherwise)
                queue.push(v);
            }
        }
    }

    return reversals;
};