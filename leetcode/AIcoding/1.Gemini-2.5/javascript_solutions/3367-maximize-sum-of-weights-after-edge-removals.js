var maximizeSumOfWeights = function(n, edges, weights) {
    const adj = Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let totalSum = 0;
    for (const w of weights) {
        totalSum += w;
    }

    const subtreeSum = Array(n).fill(0);
    let maxProduct = 0;

    function dfs(u, parent) {
        subtreeSum[u] = weights[u];
        for (const v of adj[u]) {
            if (v === parent) {
                continue;
            }
            dfs(v, u);
            subtreeSum[u] += subtreeSum[v];
        }
    }

    dfs(0, -1);

    for (let i = 0; i < n; i++) {
        // Consider cutting the edge that connects node i to its parent.
        // This splits the tree into two components:
        // 1. The subtree rooted at i, with sum subtreeSum[i].
        // 2. The rest of the tree, with sum totalSum - subtreeSum[i].
        // We ensure both components have positive sums to be considered for maximization,
        // and that subtreeSum[i] is not the total sum (i.e., it's not the entire tree itself).
        if (subtreeSum[i] > 0 && subtreeSum[i] < totalSum) {
            const currentProduct = subtreeSum[i] * (totalSum - subtreeSum[i]);
            if (currentProduct > maxProduct) {
                maxProduct = currentProduct;
            }
        }
    }

    return maxProduct;
};