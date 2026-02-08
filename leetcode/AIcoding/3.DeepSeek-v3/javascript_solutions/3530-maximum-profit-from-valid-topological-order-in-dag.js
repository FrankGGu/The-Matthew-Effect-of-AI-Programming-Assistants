var maxProfit = function(n, edges, profit) {
    const graph = new Array(n).fill(0).map(() => []);
    const inDegree = new Array(n).fill(0);

    for (const [u, v] of edges) {
        graph[u].push(v);
        inDegree[v]++;
    }

    const queue = [];
    const dp = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        if (inDegree[i] === 0) {
            queue.push(i);
        }
        dp[i] = profit[i];
    }

    let max = 0;

    while (queue.length > 0) {
        const u = queue.shift();
        max = Math.max(max, dp[u]);

        for (const v of graph[u]) {
            dp[v] = Math.max(dp[v], dp[u] + profit[v]);
            inDegree[v]--;
            if (inDegree[v] === 0) {
                queue.push(v);
            }
        }
    }

    return max;
};