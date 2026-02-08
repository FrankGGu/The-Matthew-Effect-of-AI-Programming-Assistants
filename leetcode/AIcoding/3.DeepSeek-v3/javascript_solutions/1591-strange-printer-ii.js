var isPrintable = function(targetGrid) {
    const m = targetGrid.length;
    const n = targetGrid[0].length;
    const colorSet = new Set();
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            colorSet.add(targetGrid[i][j]);
        }
    }
    const colors = Array.from(colorSet);
    const colorInfo = {};
    for (const color of colors) {
        let minX = m, minY = n, maxX = -1, maxY = -1;
        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                if (targetGrid[i][j] === color) {
                    minX = Math.min(minX, i);
                    minY = Math.min(minY, j);
                    maxX = Math.max(maxX, i);
                    maxY = Math.max(maxY, j);
                }
            }
        }
        colorInfo[color] = { minX, minY, maxX, maxY };
    }
    const graph = {};
    for (const color of colors) {
        graph[color] = new Set();
    }
    for (const color of colors) {
        const { minX, minY, maxX, maxY } = colorInfo[color];
        for (let i = minX; i <= maxX; i++) {
            for (let j = minY; j <= maxY; j++) {
                if (targetGrid[i][j] !== color) {
                    graph[color].add(targetGrid[i][j]);
                }
            }
        }
    }
    const visited = {};
    const visiting = {};
    for (const color of colors) {
        if (hasCycle(color, graph, visited, visiting)) {
            return false;
        }
    }
    return true;
};

function hasCycle(color, graph, visited, visiting) {
    if (visited[color]) return false;
    if (visiting[color]) return true;
    visiting[color] = true;
    for (const neighbor of graph[color]) {
        if (hasCycle(neighbor, graph, visited, visiting)) {
            return true;
        }
    }
    visiting[color] = false;
    visited[color] = true;
    return false;
}