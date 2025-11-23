var longestPath = function(parent, s) {
    const n = parent.length;
    const adj = Array.from({ length: n }, () => []);

    for (let i = 1; i < n; i++) {
        adj[parent[i]].push(i);
    }

    let ans = 1;

    function dfs(u) {
        let longestBranch1 = 0;
        let longestBranch2 = 0;

        for (const v of adj[u]) {
            const lenFromVDown = dfs(v);
            if (s[u] !== s[v]) {
                if (lenFromVDown > longestBranch1) {
                    longestBranch2 = longestBranch1;
                    longestBranch1 = lenFromVDown;
                } else if (lenFromVDown > longestBranch2) {
                    longestBranch2 = lenFromVDown;
                }
            }
        }

        ans = Math.max(ans, longestBranch1 + longestBranch2 + 1);
        return longestBranch1 + 1;
    }

    dfs(0);
    return ans;
};