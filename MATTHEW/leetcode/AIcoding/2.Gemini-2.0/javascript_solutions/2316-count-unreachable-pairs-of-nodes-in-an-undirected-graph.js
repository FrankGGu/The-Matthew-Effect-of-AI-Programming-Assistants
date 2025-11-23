var countPairs = function(n, edges) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const visited = Array(n).fill(false);
    let unreachablePairs = 0;
    let remainingNodes = n;

    while (remainingNodes > 0) {
        let startNode = -1;
        for (let i = 0; i < n; i++) {
            if (!visited[i]) {
                startNode = i;
                break;
            }
        }

        if (startNode === -1) break;

        let count = 0;
        const queue = [startNode];
        visited[startNode] = true;

        while (queue.length > 0) {
            const node = queue.shift();
            count++;

            for (const neighbor of adj[node]) {
                if (!visited[neighbor]) {
                    visited[neighbor] = true;
                    queue.push(neighbor);
                }
            }
        }

        unreachablePairs += count * (n - count);
        remainingNodes -= count;
    }

    return unreachablePairs / 2;
};