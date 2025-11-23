function minScore(arr, edges) {
    const n = arr.length;
    const graph = Array.from({ length: n }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }

    const parent = Array(n).fill(-1);
    const visited = Array(n).fill(false);

    function dfs(u) {
        visited[u] = true;
        for (const v of graph[u]) {
            if (!visited[v]) {
                parent[v] = u;
                dfs(v);
            }
        }
    }

    dfs(0);

    const freq = Array(n).fill(0);
    for (let i = 0; i < n; i++) {
        freq[arr[i]]++;
    }

    const sum = freq.reduce((a, b) => a + b, 0);
    let minScore = Infinity;

    for (let i = 0; i < n; i++) {
        if (parent[i] !== -1) {
            const root = parent[i];
            const size = freq[arr[i]];
            const other = sum - size;
            minScore = Math.min(minScore, Math.abs(size - other));
        }
    }

    return minScore;
}