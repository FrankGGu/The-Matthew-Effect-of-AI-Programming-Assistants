var gardenNoAdj = function(n, paths) {
    const adj = new Array(n).fill(0).map(() => []);
    for (const [u, v] of paths) {
        adj[u - 1].push(v - 1);
        adj[v - 1].push(u - 1);
    }

    const result = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        const usedColors = new Array(5).fill(false); // Indices 1-4 for colors

        for (const neighbor of adj[i]) {
            if (result[neighbor] !== 0) { // If neighbor is already colored
                usedColors[result[neighbor]] = true;
            }
        }

        for (let color = 1; color <= 4; color++) {
            if (!usedColors[color]) {
                result[i] = color;
                break;
            }
        }
    }

    return result;
};