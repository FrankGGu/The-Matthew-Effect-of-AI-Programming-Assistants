var minimumTime = function(n, relations, time) {
    const adj = Array(n).fill(null).map(() => []);
    const indegree = Array(n).fill(0);
    const dp = Array(n).fill(0);

    for (const [prev, next] of relations) {
        adj[prev - 1].push(next - 1);
        indegree[next - 1]++;
    }

    const queue = [];
    for (let i = 0; i < n; i++) {
        if (indegree[i] === 0) {
            queue.push(i);
            dp[i] = time[i];
        }
    }

    let ans = 0;
    while (queue.length > 0) {
        const u = queue.shift();
        ans = Math.max(ans, dp[u]);

        for (const v of adj[u]) {
            dp[v] = Math.max(dp[v], dp[u] + time[v]);
            indegree[v]--;
            if (indegree[v] === 0) {
                queue.push(v);
            }
        }
    }

    return ans;
};