var gardenNoAdj = function(N, paths) {
    const graph = Array.from({ length: N }, () => []);
    for (const [u, v] of paths) {
        graph[u - 1].push(v - 1);
        graph[v - 1].push(u - 1);
    }

    const result = Array(N).fill(0);

    for (let i = 0; i < N; i++) {
        const used = new Set();
        for (const neighbor of graph[i]) {
            if (result[neighbor] > 0) {
                used.add(result[neighbor]);
            }
        }
        for (let color = 1; color <= 4; color++) {
            if (!used.has(color)) {
                result[i] = color;
                break;
            }
        }
    }

    return result;
};