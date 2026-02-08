var timeToMarkAllNodes = function(n, edges, start) {
    const adj = new Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    if (n === 1) {
        return 0;
    }

    const queue = [];
    const visited = new Array(n).fill(false);
    let maxTime = 0;

    queue.push([start, 0]);
    visited[start] = true;

    let head = 0;
    while (head < queue.length) {
        const [currentNode, currentTime] = queue[head++];

        maxTime = Math.max(maxTime, currentTime);

        for (const neighbor of adj[currentNode]) {
            if (!visited[neighbor]) {
                visited[neighbor] = true;
                queue.push([neighbor, currentTime + 1]);
            }
        }
    }

    return maxTime;
};