function findSubtreeSizes(n, edges, source, target) {
    const graph = Array.from({ length: n }, () => []);
    for (let i = 0; i < edges.length; i += 2) {
        const u = edges[i];
        const v = edges[i + 1];
        graph[u].push(v);
        graph[v].push(u);
    }

    const parent = Array(n).fill(-1);
    const depth = Array(n).fill(0);
    const subtreeSize = Array(n).fill(1);

    function dfs(u, p) {
        parent[u] = p;
        for (const v of graph[u]) {
            if (v !== p) {
                depth[v] = depth[u] + 1;
                dfs(v, u);
                subtreeSize[u] += subtreeSize[v];
            }
        }
    }

    dfs(0, -1);

    const result = Array(n).fill(0);
    const map = new Map();

    for (let i = 0; i < source.length; i++) {
        const s = source[i];
        const t = target[i];
        map.set(s, t);
    }

    const visited = Array(n).fill(false);

    function updateSubtreeSizes(u) {
        visited[u] = true;
        for (const v of graph[u]) {
            if (!visited[v] && parent[v] === u) {
                updateSubtreeSizes(v);
                subtreeSize[u] -= subtreeSize[v];
                subtreeSize[v] = 1;
            }
        }
    }

    for (let i = 0; i < n; i++) {
        if (map.has(i)) {
            const newParent = map.get(i);
            const oldParent = parent[i];
            if (oldParent !== -1) {
                subtreeSize[oldParent] -= subtreeSize[i];
            }
            parent[i] = newParent;
            if (newParent !== -1) {
                subtreeSize[newParent] += subtreeSize[i];
            }
        }
    }

    for (let i = 0; i < n; i++) {
        if (parent[i] === -1) {
            updateSubtreeSizes(i);
        }
    }

    for (let i = 0; i < n; i++) {
        result[i] = subtreeSize[i];
    }

    return result;
}