var frogPosition = function(n, edges, t, target) {
    if (n === 1) return 1.0;
    const graph = Array.from({ length: n + 1 }, () => []);
    for (const [u, v] of edges) {
        graph[u].push(v);
        graph[v].push(u);
    }
    const visited = new Array(n + 1).fill(false);
    let probability = 0.0;

    const dfs = (node, time, prob) => {
        if (time > t) return;
        if (node === target && (time === t || (time < t && graph[node].length === 0) || (time < t && node !== 1 && graph[node].length === 1))) {
            probability = prob;
            return;
        }
        visited[node] = true;
        const children = graph[node].filter(child => !visited[child]);
        const size = children.length;
        for (const child of children) {
            dfs(child, time + 1, prob / size);
        }
        visited[node] = false;
    };

    dfs(1, 0, 1.0);
    return probability;
};