var eventualSafeNodes = function(graph) {
    const n = graph.length;
    const colors = new Array(n).fill(0); // 0: unvisited, 1: visiting, 2: visited

    const isSafe = (node) => {
        if (colors[node] === 2) {
            return true;
        }
        if (colors[node] === 1) {
            return false;
        }

        colors[node] = 1;

        for (const neighbor of graph[node]) {
            if (!isSafe(neighbor)) {
                return false;
            }
        }

        colors[node] = 2;
        return true;
    };

    const safeNodes = [];
    for (let i = 0; i < n; i++) {
        if (isSafe(i)) {
            safeNodes.push(i);
        }
    }

    return safeNodes;
};