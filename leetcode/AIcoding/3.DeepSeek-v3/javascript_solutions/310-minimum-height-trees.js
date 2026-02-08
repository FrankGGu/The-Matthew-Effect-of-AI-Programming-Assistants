var findMinHeightTrees = function(n, edges) {
    if (n === 1) return [0];

    const adj = Array.from({ length: n }, () => []);
    const degree = new Array(n).fill(0);

    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
        degree[u]++;
        degree[v]++;
    }

    let leaves = [];
    for (let i = 0; i < n; i++) {
        if (degree[i] === 1) leaves.push(i);
    }

    let remainingNodes = n;
    while (remainingNodes > 2) {
        const newLeaves = [];
        const leavesCount = leaves.length;
        remainingNodes -= leavesCount;

        for (let i = 0; i < leavesCount; i++) {
            const leaf = leaves[i];
            for (const neighbor of adj[leaf]) {
                degree[neighbor]--;
                if (degree[neighbor] === 1) {
                    newLeaves.push(neighbor);
                }
            }
        }
        leaves = newLeaves;
    }

    return leaves;
};