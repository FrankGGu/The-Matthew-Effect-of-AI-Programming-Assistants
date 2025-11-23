var countPairs = function(n, edges) {
    const graph = new Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        graph[u - 1].push(v - 1);
        graph[v - 1].push(u - 1);
    }

    const subtreeSizes = new Array(n).fill(0);

    const dfs = (node, parent) => {
        let size = 1;
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                size += dfs(neighbor, node);
            }
        }
        subtreeSizes[node] = size;
        return size;
    };

    dfs(0, -1);

    let totalPairs = 0;
    const totalNodes = n;

    for (let size of subtreeSizes) {
        totalPairs += size * (totalNodes - size);
    }

    return totalPairs / 2;
};