var maxProfit = function(n, edges, price) {
    const adj = Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let maxAns = 0;

    function dfs(node, parent) {
        let maxPath = 0;
        let maxPathWithoutNode = 0;

        for (const neighbor of adj[node]) {
            if (neighbor !== parent) {
                const [pathWithNode, pathWithoutNode] = dfs(neighbor, node);
                maxAns = Math.max(maxAns, maxPath + pathWithNode, maxPathWithoutNode + pathWithNode);
                maxPath = Math.max(maxPath, pathWithoutNode);
                maxPathWithoutNode = Math.max(maxPathWithoutNode, pathWithNode);
            }
        }

        maxPath += price[node];
        maxPathWithoutNode += price[node];

        maxAns = Math.max(maxAns, maxPath - price[node], maxPathWithoutNode);

        return [maxPath, maxPathWithoutNode - price[node]];
    }

    dfs(0, -1);

    return maxAns;
};