var maxScore = function(n, edges, prices) {
    const adj = new Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    let totalSum = 0;
    for (const price of prices) {
        totalSum += price;
    }

    let maxDiff = 0;

    // dfs(u, parent) returns the sum of prices in the subtree rooted at u
    const dfs = (u, parent) => {
        let currentSubtreeSum = prices[u];
        for (const v of adj[u]) {
            if (v !== parent) {
                currentSubtreeSum += dfs(v, u);
            }
        }

        // currentSubtreeSum represents the sum of prices in one of the two components
        // formed by cutting the edge (parent, u).
        // The other component's sum would be (totalSum - currentSubtreeSum).
        // We want to maximize the absolute difference between these two sums:
        // |(totalSum - currentSubtreeSum) - currentSubtreeSum|
        // which simplifies to |totalSum - 2 * currentSubtreeSum|.

        // We only consider valid cuts, meaning 'u' is not the initial root of the DFS traversal.
        // The initial root has a dummy parent (e.g., -1), and its 'currentSubtreeSum' would be the totalSum of the entire tree,
        // which doesn't correspond to a cut.
        if (parent !== -1) {
            maxDiff = Math.max(maxDiff, Math.abs(totalSum - 2 * currentSubtreeSum));
        }

        return currentSubtreeSum;
    };

    // Start DFS from node 0 with a dummy parent -1
    dfs(0, -1);

    return maxDiff;
};