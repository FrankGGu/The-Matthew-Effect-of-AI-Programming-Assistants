var eventualSafeNodes = function(graph) {
    const n = graph.length;
    const color = new Array(n).fill(0); // 0: unvisited, 1: visiting, 2: safe
    const result = [];

    const isSafe = (node) => {
        if (color[node] > 0) {
            return color[node] === 2;
        }
        color[node] = 1;
        for (const neighbor of graph[node]) {
            if (!isSafe(neighbor)) {
                return false;
            }
        }
        color[node] = 2;
        return true;
    };

    for (let i = 0; i < n; i++) {
        if (isSafe(i)) {
            result.push(i);
        }
    }
    return result;
};