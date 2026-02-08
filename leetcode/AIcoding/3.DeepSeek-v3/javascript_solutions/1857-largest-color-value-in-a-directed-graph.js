var largestPathValue = function(colors, edges) {
    const n = colors.length;
    const adj = new Array(n).fill().map(() => []);
    const indegree = new Array(n).fill(0);

    for (const [u, v] of edges) {
        adj[u].push(v);
        indegree[v]++;
    }

    const queue = [];
    const dp = new Array(n).fill().map(() => new Array(26).fill(0));

    for (let i = 0; i < n; i++) {
        if (indegree[i] === 0) {
            queue.push(i);
            dp[i][colors.charCodeAt(i) - 97] = 1;
        }
    }

    let visited = 0;
    let maxColorValue = 0;

    while (queue.length > 0) {
        const u = queue.shift();
        visited++;

        const currentMax = Math.max(...dp[u]);
        maxColorValue = Math.max(maxColorValue, currentMax);

        for (const v of adj[u]) {
            for (let c = 0; c < 26; c++) {
                const newVal = dp[u][c] + (colors.charCodeAt(v) - 97 === c ? 1 : 0);
                dp[v][c] = Math.max(dp[v][c], newVal);
            }
            indegree[v]--;
            if (indegree[v] === 0) {
                queue.push(v);
            }
        }
    }

    return visited === n ? maxColorValue : -1;
};