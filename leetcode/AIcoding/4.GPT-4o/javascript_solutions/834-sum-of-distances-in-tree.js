var sumOfDistancesInTree = function(N, edges) {
    const graph = Array.from({ length: N }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const ans = new Array(N).fill(0);
    const count = new Array(N).fill(1);

    const dfs1 = (node, parent) => {
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                dfs1(neighbor, node);
                count[node] += count[neighbor];
                ans[node] += ans[neighbor] + count[neighbor];
            }
        }
    };

    const dfs2 = (node, parent) => {
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                ans[neighbor] = ans[node] - count[neighbor] + (N - count[neighbor]);
                dfs2(neighbor, node);
            }
        }
    };

    dfs1(0, -1);
    dfs2(0, -1);
    return ans;
};