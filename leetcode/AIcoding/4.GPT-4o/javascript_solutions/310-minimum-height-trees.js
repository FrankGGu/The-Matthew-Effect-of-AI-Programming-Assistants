var findMinHeightTrees = function(n, edges) {
    if (n === 1) return [0];
    const graph = new Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    let leaves = [];
    for (let i = 0; i < n; i++) {
        if (graph[i].length === 1) leaves.push(i);
    }

    while (n > 2) {
        n -= leaves.length;
        const newLeaves = [];
        for (const leaf of leaves) {
            const neighbor = graph[leaf].pop();
            graph[neighbor] = graph[neighbor].filter(x => x !== leaf);
            if (graph[neighbor].length === 1) newLeaves.push(neighbor);
        }
        leaves = newLeaves;
    }

    return leaves;
};