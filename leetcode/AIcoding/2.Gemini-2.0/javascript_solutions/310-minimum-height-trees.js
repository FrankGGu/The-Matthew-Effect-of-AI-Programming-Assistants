var findMinHeightTrees = function(n, edges) {
    if (n <= 0) return [];
    if (n === 1) return [0];

    const adj = new Array(n).fill(null).map(() => []);
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

    let count = n;
    while (count > 2) {
        const size = leaves.length;
        count -= size;

        const newLeaves = [];
        for (let i = 0; i < size; i++) {
            const leaf = leaves[i];
            for (const neighbor of adj[leaf]) {
                degree[neighbor]--;
                if (degree[neighbor] === 1) {
                    newLeaves.push(neighbor);
                }
            }
        }
        leaves.length = 0;
        for(let i = 0; i < newLeaves.length; i++){
            leaves.push(newLeaves[i]);
        }
    }

    return leaves;
};