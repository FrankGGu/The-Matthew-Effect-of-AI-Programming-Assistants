var isBipartite = function(graph) {
    const n = graph.length;
    const colors = new Array(n).fill(-1);

    for (let i = 0; i < n; i++) {
        if (colors[i] === -1) {
            const queue = [i];
            colors[i] = 0;

            while (queue.length > 0) {
                const node = queue.shift();
                for (const neighbor of graph[node]) {
                    if (colors[neighbor] === -1) {
                        colors[neighbor] = colors[node] ^ 1;
                        queue.push(neighbor);
                    } else if (colors[neighbor] === colors[node]) {
                        return false;
                    }
                }
            }
        }
    }
    return true;
};