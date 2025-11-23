function gardenNoAdj(n, paths) {
    const graph = Array(n).fill().map(() => []);
    for (const [a, b] of paths) {
        graph[a - 1].push(b - 1);
        graph[b - 1].push(a - 1);
    }

    const result = Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        const used = new Set();
        for (const neighbor of graph[i]) {
            if (result[neighbor] !== 0) {
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
}