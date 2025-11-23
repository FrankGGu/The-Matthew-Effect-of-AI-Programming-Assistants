function findSmallestVertex(weights, edges) {
    const n = weights.length;
    const graph = Array.from({ length: n }, () => []);

    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const parent = new Array(n).fill(-1);
    const subtreeSum = new Array(n).fill(0);

    function dfs(u) {
        let sum = weights[u];
        for (const v of graph[u]) {
            if (v !== parent[u]) {
                parent[v] = u;
                sum += dfs(v);
            }
        }
        subtreeSum[u] = sum;
        return sum;
    }

    dfs(0);

    function getEquilibriumNode(u) {
        let total = subtreeSum[0];
        let minSum = Infinity;
        let result = u;

        function dfs2(u, p) {
            let currentSum = weights[u];
            for (const v of graph[u]) {
                if (v !== p) {
                    currentSum += subtreeSum[v];
                }
            }

            let left = total - currentSum;
            let right = currentSum;

            if (Math.abs(left - right) < Math.abs(minSum)) {
                minSum = left - right;
                result = u;
            } else if (Math.abs(left - right) === Math.abs(minSum) && u < result) {
                result = u;
            }

            for (const v of graph[u]) {
                if (v !== p) {
                    dfs2(v, u);
                }
            }
        }

        dfs2(u, -1);
        return result;
    }

    return Array.from({ length: n }, (_, i) => getEquilibriumNode(i));
}