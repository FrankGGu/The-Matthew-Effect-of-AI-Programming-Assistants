var countSubTrees = function(n, edges, labels) {
    const tree = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        tree[u].push(v);
        tree[v].push(u);
    }

    const result = new Array(n).fill(0);
    const visited = new Array(n).fill(false);

    const dfs = (node) => {
        visited[node] = true;
        const count = new Array(26).fill(0);
        const label = labels.charCodeAt(node) - 97;
        count[label]++;

        for (const neighbor of tree[node]) {
            if (!visited[neighbor]) {
                const childCount = dfs(neighbor);
                for (let i = 0; i < 26; i++) {
                    count[i] += childCount[i];
                }
            }
        }

        result[node] = count[label];
        return count;
    };

    dfs(0);
    return result;
};