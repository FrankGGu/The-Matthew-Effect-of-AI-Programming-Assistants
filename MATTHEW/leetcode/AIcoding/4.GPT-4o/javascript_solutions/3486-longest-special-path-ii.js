var longestPath = function(parent, s) {
    const graph = new Map();
    for (let i = 0; i < parent.length; i++) {
        if (!graph.has(parent[i])) {
            graph.set(parent[i], []);
        }
        graph.get(parent[i]).push(i);
    }

    let maxLength = 1;

    const dfs = (node) => {
        let maxLen1 = 0, maxLen2 = 0;
        for (const child of (graph.get(node) || [])) {
            const childLen = dfs(child);
            if (s[child] !== s[node]) {
                if (childLen > maxLen1) {
                    maxLen2 = maxLen1;
                    maxLen1 = childLen;
                } else if (childLen > maxLen2) {
                    maxLen2 = childLen;
                }
            }
        }
        maxLength = Math.max(maxLength, maxLen1 + maxLen2 + 1);
        return maxLen1 + 1;
    };

    dfs(0);
    return maxLength;
};