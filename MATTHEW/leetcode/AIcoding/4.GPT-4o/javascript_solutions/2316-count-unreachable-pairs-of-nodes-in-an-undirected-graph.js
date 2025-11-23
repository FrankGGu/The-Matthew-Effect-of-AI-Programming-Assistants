var countPairs = function(n, edges) {
    const graph = new Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const visited = new Array(n).fill(false);
    const size = [];

    const dfs = (node) => {
        visited[node] = true;
        let count = 1;
        for (const neighbor of graph[node]) {
            if (!visited[neighbor]) {
                count += dfs(neighbor);
            }
        }
        return count;
    };

    for (let i = 0; i < n; i++) {
        if (!visited[i]) {
            size.push(dfs(i));
        }
    }

    let totalUnreachablePairs = 0;
    const totalNodes = n;
    let sum = 0;

    for (const s of size) {
        totalUnreachablePairs += s * (totalNodes - sum - s);
        sum += s;
    }

    return totalUnreachablePairs;
};