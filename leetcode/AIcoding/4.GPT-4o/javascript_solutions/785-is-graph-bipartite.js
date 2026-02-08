function isBipartite(graph) {
    const n = graph.length;
    const color = Array(n).fill(-1);

    for (let i = 0; i < n; i++) {
        if (color[i] === -1) {
            const queue = [i];
            color[i] = 0;

            while (queue.length) {
                const node = queue.shift();

                for (const neighbor of graph[node]) {
                    if (color[neighbor] === -1) {
                        color[neighbor] = 1 - color[node];
                        queue.push(neighbor);
                    } else if (color[neighbor] === color[node]) {
                        return false;
                    }
                }
            }
        }
    }
    return true;
}