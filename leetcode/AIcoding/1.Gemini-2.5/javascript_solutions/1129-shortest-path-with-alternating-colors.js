var shortestAlternatingPaths = function(n, redEdges, blueEdges) {
    const adj = Array(n).fill(0).map(() => [[], []]); // adj[node][color] stores list of neighbors
                                                      // color 0 for red, 1 for blue

    for (const [u, v] of redEdges) {
        adj[u][0].push(v);
    }
    for (const [u, v] of blueEdges) {
        adj[u][1].push(v);
    }

    // dist[node][color] stores the shortest path length to 'node'
    // where the last edge taken was of 'color'.
    const dist = Array(n).fill(0).map(() => [Infinity, Infinity]);

    // answer[i] will store the minimum of dist[i][0] and dist[i][1]
    const answer = Array(n).fill(Infinity);

    const queue = [];

    // Initial states: From node 0, we can take a red edge or a blue edge.
    // The distance to node 0 itself is 0.
    // We initialize two states for node 0, one for each possible starting color
    // for the *next* edge.
    // [node, distance, lastColor]
    queue.push([0, 0, 0]); // Arriving at 0, conceptually the last edge was 'red' (for next step)
    dist[0][0] = 0;
    queue.push([0, 0, 1]); // Arriving at 0, conceptually the last edge was 'blue' (for next step)
    dist[0][1] = 0;

    answer[0] = 0; // Shortest path to node 0 is 0.

    let head = 0;
    while (head < queue.length) {
        const [u, d, lastColor] = queue[head++];

        // Update the overall shortest path to node u
        answer[u] = Math.min(answer[u], d);

        const nextColor = 1 - lastColor; // Alternate color

        // Explore neighbors reachable by 'nextColor' edges
        for (const v of adj[u][nextColor]) {
            if (d + 1 < dist[v][nextColor]) {
                dist[v][nextColor] = d + 1;
                queue.push([v, d + 1, nextColor]);
            }
        }
    }

    // After BFS, fill -1 for unreachable nodes
    for (let i = 0; i < n; i++) {
        if (answer[i] === Infinity) {
            answer[i] = -1;
        }
    }

    return answer;
};