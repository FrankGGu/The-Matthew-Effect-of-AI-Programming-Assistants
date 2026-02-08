var gardenNoAdj = function(n, edges) {
    const adj = new Array(n).fill(null).map(() => []);
    for (const [u, v] of edges) {
        adj[u - 1].push(v - 1);
        adj[v - 1].push(u - 1);
    }

    const colors = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        const usedColors = new Set();
        for (const neighbor of adj[i]) {
            if (colors[neighbor] !== 0) {
                usedColors.add(colors[neighbor]);
            }
        }

        for (let color = 1; color <= 4; color++) {
            if (!usedColors.has(color)) {
                colors[i] = color;
                break;
            }
        }
    }

    return colors;
};