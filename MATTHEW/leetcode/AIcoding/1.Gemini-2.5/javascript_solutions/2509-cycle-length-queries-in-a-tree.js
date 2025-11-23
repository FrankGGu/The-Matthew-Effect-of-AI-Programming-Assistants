var cycleLengthQueries = function(n, queries) {
    const depths = new Array(n + 1);
    depths[1] = 0;
    for (let i = 2; i <= n; i++) {
        depths[i] = depths[Math.floor(i / 2)] + 1;
    }

    const results = [];

    const getLCA = (u, v) => {
        let currentU = u;
        let currentV = v;
        let depthU = depths[currentU];
        let depthV = depths[currentV];

        while (depthU > depthV) {
            currentU = Math.floor(currentU / 2);
            depthU--;
        }
        while (depthV > depthU) {
            currentV = Math.floor(currentV / 2);
            depthV--;
        }

        while (currentU !== currentV) {
            currentU = Math.floor(currentU / 2);
            currentV = Math.floor(currentV / 2);
        }
        return currentU;
    };

    for (const [u, v] of queries) {
        const lca = getLCA(u, v);
        const dist = depths[u] + depths[v] - 2 * depths[lca];
        results.push(dist + 1);
    }

    return results;
};