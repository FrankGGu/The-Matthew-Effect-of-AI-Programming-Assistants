var isBipartite = function(graph) {
    const n = graph.length;
    const colors = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        if (colors[i] === 0) {
            const queue = [i];
            colors[i] = 1;

            let head = 0;
            while (head < queue.length) {
                const u = queue[head++];
                const uColor = colors[u];

                for (const v of graph[u]) {
                    if (colors[v] === 0) {
                        colors[v] = -uColor;
                        queue.push(v);
                    } else if (colors[v] === uColor) {
                        return false;
                    }
                }
            }
        }
    }

    return true;
};