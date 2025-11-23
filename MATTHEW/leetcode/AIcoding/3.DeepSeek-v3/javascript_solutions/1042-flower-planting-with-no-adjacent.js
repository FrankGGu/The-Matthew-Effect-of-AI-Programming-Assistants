var gardenNoAdj = function(N, paths) {
    const graph = new Array(N + 1).fill(0).map(() => []);
    for (const [u, v] of paths) {
        graph[u].push(v);
        graph[v].push(u);
    }
    const res = new Array(N + 1).fill(0);
    for (let i = 1; i <= N; i++) {
        const used = new Array(5).fill(false);
        for (const neighbor of graph[i]) {
            used[res[neighbor]] = true;
        }
        for (let color = 1; color <= 4; color++) {
            if (!used[color]) {
                res[i] = color;
                break;
            }
        }
    }
    return res.slice(1);
};