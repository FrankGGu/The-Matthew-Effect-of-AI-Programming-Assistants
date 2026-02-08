var largestPathValue = function(colors, edges) {
    const n = colors.length;
    const adj = Array(n).fill(null).map(() => []);
    const indegree = Array(n).fill(0);

    for (const [u, v] of edges) {
        adj[u].push(v);
        indegree[v]++;
    }

    const dp = Array(n).fill(null).map(() => Array(26).fill(0));
    let queue = [];
    for (let i = 0; i < n; i++) {
        if (indegree[i] === 0) {
            queue.push(i);
            dp[i][colors.charCodeAt(i) - 'a'.charCodeAt(0)] = 1;
        }
    }

    let visited = 0;
    let ans = 0;
    while (queue.length > 0) {
        const u = queue.shift();
        visited++;
        ans = Math.max(ans, Math.max(...dp[u]));

        for (const v of adj[u]) {
            for (let i = 0; i < 26; i++) {
                dp[v][i] = Math.max(dp[v][i], dp[u][i] + (colors.charCodeAt(v) - 'a'.charCodeAt(0) === i ? 1 : 0));
            }
            indegree[v]--;
            if (indegree[v] === 0) {
                queue.push(v);
            }
        }
    }

    return visited === n ? ans : -1;
};