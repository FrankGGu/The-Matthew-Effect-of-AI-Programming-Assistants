var findMinHeightTrees = function(n, edges) {
    if (n === 1) {
        return [0];
    }

    const adj = new Array(n).fill(0).map(() => []);
    const degree = new Array(n).fill(0);

    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
        degree[u]++;
        degree[v]++;
    }

    const leaves = [];
    for (let i = 0; i < n; i++) {
        if (degree[i] === 1) {
            leaves.push(i);
        }
    }

    let remainingNodes = n;
    let queue = leaves;

    while (remainingNodes > 2) {
        const currentLevelSize = queue.length;
        remainingNodes -= currentLevelSize;
        const nextQueue = [];

        for (let i = 0; i < currentLevelSize; i++) {
            const leaf = queue[i];
            for (const neighbor of adj[leaf]) {
                degree[neighbor]--;
                if (degree[neighbor] === 1) {
                    nextQueue.push(neighbor);
                }
            }
        }
        queue = nextQueue;
    }

    return queue;
};