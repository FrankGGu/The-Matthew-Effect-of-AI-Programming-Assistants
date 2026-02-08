var maximumScoreAfterOperations = function(edges, values) {
    const n = values.length;
    const adj = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const memo = new Map();

    function dfs(node, parent) {
        const key = `${node},${parent}`;
        if (memo.has(key)) return memo.get(key);

        let total = values[node];
        let sumChildren = 0;
        let isLeaf = true;

        for (const child of adj[node]) {
            if (child !== parent) {
                isLeaf = false;
                const [childTotal, childSum] = dfs(child, node);
                total += childTotal;
                sumChildren += childSum;
            }
        }

        if (isLeaf) {
            memo.set(key, [values[node], 0]);
            return [values[node], 0];
        } else {
            const maxSum = Math.max(values[node] + sumChildren, total - values[node]);
            memo.set(key, [total, maxSum]);
            return [total, maxSum];
        }
    }

    const [total, maxSum] = dfs(0, -1);
    return maxSum;
};