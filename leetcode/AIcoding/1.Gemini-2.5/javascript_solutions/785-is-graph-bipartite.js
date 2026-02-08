var isBipartite = function(graph) {
    const n = graph.length;
    const colors = new Array(n).fill(-1); // -1: uncolored, 0: color A, 1: color B

    for (let i = 0; i < n; i++) {
        if (colors[i] === -1) { // If node i is uncolored, start BFS from it
            const queue = [];
            queue.push(i);
            colors[i] = 0; // Assign initial color 0

            while (queue.length > 0) {
                const u = queue.shift();

                for (const v of graph[u]) {
                    if (colors[v] === -1) { // If neighbor v is uncolored
                        colors[v] = 1 - colors[u]; // Assign opposite color
                        queue.push(v);
                    } else if (colors[v] === colors[u]) { // If neighbor v has the same color
                        return false; // Not bipartite
                    }
                }
            }
        }
    }

    return true; // All nodes successfully colored without conflict
};