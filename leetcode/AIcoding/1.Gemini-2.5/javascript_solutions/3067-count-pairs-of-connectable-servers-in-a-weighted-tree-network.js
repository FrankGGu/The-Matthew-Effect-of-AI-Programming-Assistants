var countPairsOfConnectableServers = function(edges, signalSpeed) {
    const n = edges.length + 1;
    const adj = Array.from({ length: n }, () => []);

    for (const [u, v, weight] of edges) {
        adj[u].push([v, weight]);
        adj[v].push([u, weight]);
    }

    const ans = new Array(n).fill(0);

    const dfs = (u, p, distFromMainRoot, signalSpeed, adj) => {
        let count = 0;
        if (distFromMainRoot % signalSpeed === 0) {
            count++;
        }

        for (const [v, w] of adj[u]) {
            if (v !== p) {
                count += dfs(v, u, distFromMainRoot + w, signalSpeed, adj);
            }
        }
        return count;
    };

    for (let i = 0; i < n; i++) {
        let sumOfValidNodesInPrevBranches = 0;

        for (const [neighbor, weight] of adj[i]) {
            const currentBranchValidNodes = dfs(neighbor, i, weight, signalSpeed, adj);

            ans[i] += sumOfValidNodesInPrevBranches * currentBranchValidNodes;

            sumOfValidNodesInPrevBranches += currentBranchValidNodes;
        }
    }

    return ans;
};