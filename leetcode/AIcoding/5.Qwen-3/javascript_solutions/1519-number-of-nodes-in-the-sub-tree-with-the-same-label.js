function countSubTrees(n, edges, labels) {
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const result = Array(n).fill(0);
    const visited = Array(n).fill(false);

    function dfs(node) {
        const count = Array(26).fill(0);
        visited[node] = true;
        const labelIndex = labels[node].charCodeAt(0) - 'a'.charCodeAt(0);
        count[labelIndex] = 1;

        for (const neighbor of graph[node]) {
            if (!visited[neighbor]) {
                const childCount = dfs(neighbor);
                for (let i = 0; i < 26; i++) {
                    count[i] += childCount[i];
                }
            }
        }

        result[node] = count[labelIndex];
        return count;
    }

    dfs(0);
    return result;
}