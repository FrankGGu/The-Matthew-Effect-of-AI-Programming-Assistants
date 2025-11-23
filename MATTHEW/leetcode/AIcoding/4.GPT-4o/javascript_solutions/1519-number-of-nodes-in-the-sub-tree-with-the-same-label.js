var countSubTrees = function(n, edges, labels) {
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const result = Array(n).fill(0);
    const dfs = (node, parent) => {
        const count = Array(26).fill(0);
        for (const neighbor of graph[node]) {
            if (neighbor !== parent) {
                const childCount = dfs(neighbor, node);
                for (let i = 0; i < 26; i++) {
                    count[i] += childCount[i];
                }
            }
        }
        count[labels.charCodeAt(node) - 'a'.charCodeAt(0)]++;
        result[node] = count[labels.charCodeAt(node) - 'a'.charCodeAt(0)];
        return count;
    };

    dfs(0, -1);
    return result;
};