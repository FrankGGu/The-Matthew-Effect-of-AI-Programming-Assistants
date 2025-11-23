var minTrioDegree = function(n, edges) {
    const graph = Array.from({ length: n + 1 }, () => new Set());
    const degree = new Array(n + 1).fill(0);

    for (const [u, v] of edges) {
        graph[u].add(v);
        graph[v].add(u);
        degree[u]++;
        degree[v]++;
    }

    let minDegree = Infinity;

    for (let i = 1; i <= n; i++) {
        for (let j of graph[i]) {
            if (j > i) {
                for (let k of graph[j]) {
                    if (k > j && graph[i].has(k)) {
                        const trioDegree = degree[i] + degree[j] + degree[k] - 6;
                        minDegree = Math.min(minDegree, trioDegree);
                    }
                }
            }
        }
    }

    return minDegree === Infinity ? -1 : minDegree;
};