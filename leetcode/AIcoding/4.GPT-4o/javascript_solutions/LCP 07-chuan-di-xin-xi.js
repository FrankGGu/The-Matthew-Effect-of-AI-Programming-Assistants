function numOfMessages(n, relations, time, target) {
    const graph = Array.from({ length: n + 1 }, () => []);
    for (const [a, b] of relations) {
        graph[a].push(b);
    }

    const dp = Array(n + 1).fill(-1);

    function dfs(node) {
        if (dp[node] !== -1) return dp[node];
        let maxTime = 0;
        for (const neighbor of graph[node]) {
            maxTime = Math.max(maxTime, dfs(neighbor));
        }
        dp[node] = maxTime + time[node - 1];
        return dp[node];
    }

    dfs(1);

    let messageCount = 0;
    for (let i = 1; i <= n; i++) {
        if (dp[i] === target) {
            messageCount++;
        }
    }

    return messageCount;
}