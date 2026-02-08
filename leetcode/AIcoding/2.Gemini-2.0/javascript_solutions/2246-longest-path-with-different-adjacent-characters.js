var longestPath = function(parent, s) {
    const n = parent.length;
    const adj = Array(n).fill(null).map(() => []);
    for (let i = 1; i < n; i++) {
        adj[parent[i]].push(i);
    }

    let maxLen = 1;

    function dfs(node) {
        let best = 0;
        let secondBest = 0;

        for (const neighbor of adj[node]) {
            const len = dfs(neighbor);
            if (s[node] !== s[neighbor]) {
                if (len > best) {
                    secondBest = best;
                    best = len;
                } else if (len > secondBest) {
                    secondBest = len;
                }
            }
        }

        maxLen = Math.max(maxLen, best + secondBest + 1);
        return best + 1;
    }

    dfs(0);
    return maxLen;
};