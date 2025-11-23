var countSubTrees = function(n, edges, labels) {
    const adj = new Array(n).fill(0).map(() => []);
    for (const [u, v] of edges) {
        adj[u].push(v);
        adj[v].push(u);
    }

    const result = new Array(n).fill(0);

    const charToIndex = (char) => char.charCodeAt(0) - 'a'.charCodeAt(0);

    const dfs = (u, p) => {
        const counts = new Array(26).fill(0);

        const uLabelIndex = charToIndex(labels[u]);
        counts[uLabelIndex] = 1;

        for (const v of adj[u]) {
            if (v === p) {
                continue;
            }
            const childCounts = dfs(v, u);
            for (let i = 0; i < 26; i++) {
                counts[i] += childCounts[i];
            }
        }

        result[u] = counts[uLabelIndex];
        return counts;
    };

    dfs(0, -1);

    return result;
};